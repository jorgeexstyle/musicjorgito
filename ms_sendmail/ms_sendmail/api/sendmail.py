from django.http import JsonResponse, HttpResponse
from rest_framework.decorators import api_view
from rest_framework import status
from ms_sendmail.api.service.sendmailservice import build_and_send
import json

@api_view(['GET'])
def send_success_mail(request, toList):
    print('INIT send_success_mail')
    print('toList: {0}'.format(toList))
    #build and send mail 
    build_and_send(toList)
    status_code = status.HTTP_200_OK    
    return HttpResponse("sendmail successful.", content_type="text/plain", status=status_code)



