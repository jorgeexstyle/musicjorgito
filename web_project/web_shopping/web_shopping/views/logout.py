from django.contrib.auth import logout
from django.shortcuts import redirect

def logout_user(request): 
    print('logout')
    try:    
        logout(request)
    except Exception as e:
        print('Error: ', e)        
    return redirect('home/')