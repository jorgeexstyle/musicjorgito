from django.shortcuts import render

def error_401_page(request): 
    return render(request, 'error-401.html')

def error_401(request, exception): 
    print(exception)
    return render(request, 'error-401.html')

def error_403_page(request):
    return render(request, 'error-403.html')

def error_403(request, exception):
    print(exception) 
    return render(request, 'error-403.html')

def error_404_page(request): 
    return render(request, 'error-404.html')        

def error_404(request, exception): 
    print(exception)
    return render(request, 'error-404.html')        
