import json
from django.http import HttpResponse
from django.contrib.auth import authenticate
from django.db.utils import IntegrityError
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view
from rest_framework import status


def create_token(username, password):
    print('create_token')
    try:
        user = authenticate(username=username, password=password)
        try:
            print('new token')
            token = Token.objects.create(user=user)
            print('token -> {0}'.format(token))
            body = {'token': token.key,
                          'created': token.created
                    }
        except IntegrityError as e:
            print('delete token')
            token = Token.objects.get(user=user)
            token.delete()
            print('new token')
            token = Token.objects.create(user=user)
            body = {'token': token.key,
                          'created': token.created
                    }
        return HttpResponse(json.dumps(body, default=str), content_type="application/json", status=status.HTTP_200_OK)                                
    except Exception as e:
        print('Error {0}'.format(e))
        return HttpResponse('Not Authorized.', content_type="application/json", status=status.HTTP_401_UNAUTHORIZED)                                


@api_view(['POST'])
def token(request):
    print('token')
    try:
        user_pass = json.loads(request.body.decode("utf-8"))
        print('user -> {0}'.format(user_pass))
        username = user_pass.get('username')
        password = user_pass.get('password')
        return create_token(username, password)
    except Exception as e:
        print('Error {0}'.format(e))
        return HttpResponse('Not Authorized.', content_type="application/json", status=status.HTTP_401_UNAUTHORIZED)                                
