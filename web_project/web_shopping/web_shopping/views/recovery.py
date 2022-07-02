from django.shortcuts import render
from web_shopping.util.sendmail import build_user_pass

def load(request):
    state = None
    message = None
    if request.method == 'GET':
        username = request.GET.get('username')
        token = request.GET.get('token')
        print('username', username)
        print('token', token)
        message, state =  build_user_pass(username, token)
    return render(request, 'recovery.html', {'state': state, 'message': message})