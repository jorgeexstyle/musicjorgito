from django.shortcuts import render, redirect
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from web_shopping.persistence.models import Country
from web_shopping.views.login import authorization

headers = ['ID', 'COUNTRY NAME', 'ALPHA2 CODE',
           'ALPHA3 CODE', 'NUMERIC COUNTRY', 'COUNTRY DETAIL']

quantity_element = 15


def load(request):
    auth, error = authorization(request, 'view_country')
    if not auth:
        return redirect(error)    
    countries = []
    state, message = save_or_update_or_delete(request)
    try:
        paginator = Paginator(find_all(), quantity_element)
        if request.method == 'GET':
            page = request.GET.get('page', 1)
        if request.method == 'POST':
            page = request.POST.get('page', 1)
        if int(page) < 1:
            page = 1
        countries = paginator.page(page)
        size = paginator.num_pages
    except (PageNotAnInteger, ValueError):
        print('page not an integer')
        page = 1
        countries = paginator.page(1)
        size = paginator.num_pages
    except EmptyPage:
        print('empty page')
        countries = paginator.page(paginator.num_pages)
        size = paginator.num_pages
        page = size
    return render(request, 'country.html', {'headers': headers, 'countries': countries, 'size': size, 'options': load_options(size), 'page': int(page), 'state': state, 'message': message})


def save_or_update_or_delete(request):
    if request.method == 'POST':
        try:
            action = request.POST.get('action')
            country = Country()
            country.country_name = request.POST.get('country-name')
            country.alpha2_code = request.POST.get('alpha2-code')
            country.alpha3_code = request.POST.get('alpha3-code')
            country.numeric_country = request.POST.get('numeric-country')
            country.country_detail = request.POST.get('country-detail')
            if action == 'save':
                country.save()
                return True, 'country saved.'
            if action == 'update':
                country.id = request.POST.get('id')
                country.save(force_update=True)
                return True, 'country updated.'
            if action == 'delete':
                country = Country.objects.get(pk=request.POST.get('id'))
                country.delete()
                return True, 'country deleted.'
        except Exception as e:
            print('Error: ', e)
            if action == 'save':
                return False, 'error saved.'
            if action == 'update':
                return False, 'error updated.'
            if action == 'delete':
                return False, 'error deleted.'                
    else:
        return None, None


def load_options(size):
    options = []
    if size != None:
        for i in range(1, size):
            options.append(i)
    return options


def find_all():
    return Country.objects.all()
