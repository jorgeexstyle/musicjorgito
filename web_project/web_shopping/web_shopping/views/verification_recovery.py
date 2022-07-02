from django.shortcuts import render
from web_shopping.util.sendmail import build_token_recovery_pass

def load(request):
    state = None
    message = None
    if request.method == 'POST':
        recovery_url = request.build_absolute_uri()
        recovery_url = recovery_url.replace('verification-recovery', 'recovery')
        message, state =  build_token_recovery_pass(request.POST.get('username'), recovery_url)
    return render(request, 'verification-recovery.html', {'state': state, 'message': message})
    