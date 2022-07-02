from django.contrib import admin
from web_shopping.persistence import models
from django.contrib.auth.models import Permission, ContentType


def load():
    admin.site.register(Permission)
    admin.site.register(ContentType)
    admin.site.register(models.Country)
