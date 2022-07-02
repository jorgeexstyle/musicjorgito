from django.shortcuts import redirect, render
from django.contrib.auth import login, authenticate
from web_shopping.util.autogenerate import generate

def authentication(request):
    if request.method == 'POST':
        try:
            username = request.POST.get('username')
            password = request.POST.get('password')
            user = authenticate(username=username, password=password)
            login(request, user)            
        except Exception as e:
            print('Error: ', e)
    return redirect('home/')

def authorization(request, perm):
    print('authorization | user -> ', request.user)

    if request.user != None and request.user.__str__() != 'AnonymousUser':
        if request.user.has_perm(perm):
            print('Authorized')
            return True, ''
        else:
            print('Forbidden')
            return False, '/error-403/'
    else:
        print('Unauthorized')
        return False, '/error-401/'

def send_mail_recovery_pass(username):
    return None

def recovery_pass(request):
    print('new key', generate(32))
    return None                             