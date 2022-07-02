from django.db import models


class Address(models.Model):
    id = models.BigAutoField(primary_key=True)
    street_name = models.CharField(max_length=100, blank=True, null=True)
    street_number = models.CharField(max_length=15, blank=True, null=True)
    postal_code = models.CharField(max_length=20, blank=True, null=True)
    latitude = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    longitude = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    altitude = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    city_code = models.ForeignKey('City', models.DO_NOTHING, db_column='city_code', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'address'


class AddressSupplier(models.Model):
    id = models.BigAutoField(primary_key=True)
    street_name = models.CharField(max_length=100, blank=True, null=True)
    street_number = models.CharField(max_length=15, blank=True, null=True)
    postal_code = models.CharField(max_length=20, blank=True, null=True)
    latitude = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    longitude = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    altitude = models.DecimalField(max_digits=65535, decimal_places=65535, blank=True, null=True)
    city_code = models.ForeignKey('City', models.DO_NOTHING, db_column='city_code', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'address_supplier'


class AuthGroup(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    id = models.BigAutoField(primary_key=True)
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class AuthtokenToken(models.Model):
    key = models.CharField(primary_key=True, max_length=40)
    created = models.DateTimeField()
    user = models.OneToOneField(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'authtoken_token'


class BillingType(models.Model):
    id = models.BigAutoField(primary_key=True)
    billing_name = models.CharField(max_length=100, blank=True, null=True)
    billing_detail = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'billing_type'


class Brand(models.Model):
    id = models.BigAutoField(primary_key=True)
    brand_name = models.CharField(max_length=100, blank=True, null=True)
    brand_description = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'brand'


class Category(models.Model):
    id = models.BigAutoField(primary_key=True)
    category_name = models.CharField(max_length=100, blank=True, null=True)
    category_description = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'category'


class City(models.Model):
    id = models.BigAutoField(primary_key=True)
    city_name = models.CharField(max_length=100, blank=True, null=True)
    city_numeric = models.CharField(max_length=6, blank=True, null=True)
    city_detail = models.CharField(max_length=250, blank=True, null=True)
    state_code = models.ForeignKey('States', models.DO_NOTHING, db_column='state_code', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'city'


class Country(models.Model):
    id = models.BigAutoField(primary_key=True)
    country_name = models.CharField(max_length=100, blank=True, null=True)
    alpha2_code = models.CharField(max_length=2, blank=True, null=True)
    alpha3_code = models.CharField(max_length=3, blank=True, null=True)
    numeric_country = models.CharField(max_length=3, blank=True, null=True)
    country_detail = models.CharField(max_length=250, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'country'


class Currency(models.Model):
    id = models.BigAutoField(primary_key=True)
    currency_name = models.CharField(max_length=120, blank=True, null=True)
    symbol = models.CharField(max_length=1, blank=True, null=True)
    country_code = models.ForeignKey(Country, models.DO_NOTHING, db_column='country_code', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'currency'


class CurrencyConverter(models.Model):
    from_currency_code = models.ForeignKey(Currency, models.DO_NOTHING, related_name ='from_currency_code', db_column='from_currency_code')
    to_currency_code = models.ForeignKey(Currency, models.DO_NOTHING, related_name ='to_currency_code', db_column='to_currency_code')
    currency_day = models.DateField()
    amount = models.DecimalField(max_digits=65535, decimal_places=65535)

    class Meta:
        managed = False
        db_table = 'currency_converter'
        constraints = [
            models.UniqueConstraint(
                fields=['from_currency_code', 'to_currency_code', 'currency_day'], name='unique_currency_converter'
            )
        ]

class DjangoAdminLog(models.Model):
    id = models.BigAutoField(primary_key=True)
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    id = models.BigAutoField(primary_key=True)
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class PayMethod(models.Model):
    id = models.BigAutoField(primary_key=True)
    pay_name = models.CharField(max_length=150, blank=True, null=True)
    pay_detail = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pay_method'


class Person(models.Model):
    id = models.BigAutoField(primary_key=True)
    person_name = models.CharField(max_length=150, blank=True, null=True)
    last_name = models.CharField(max_length=150, blank=True, null=True)
    second_last_name = models.CharField(max_length=150, blank=True, null=True)
    birdthday = models.DateField(blank=True, null=True)
    person_phone = models.CharField(max_length=20, blank=True, null=True)
    person_email = models.CharField(max_length=80, blank=True, null=True)
    address_code = models.ForeignKey(Address, models.DO_NOTHING, db_column='address_code', blank=True, null=True)
    national_identification = models.CharField(max_length=60, blank=True, null=True)
    sex_code = models.ForeignKey('Sex', models.DO_NOTHING, db_column='sex_code', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'person'


class Product(models.Model):
    id = models.BigAutoField(primary_key=True)
    product_name = models.CharField(max_length=150, blank=True, null=True)
    product_description = models.CharField(max_length=200, blank=True, null=True)
    brand_code = models.ForeignKey(Brand, models.DO_NOTHING, db_column='brand_code', blank=True, null=True)
    category_code = models.ForeignKey(Category, models.DO_NOTHING, db_column='category_code', blank=True, null=True)
    img_url = models.CharField(max_length=250, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'product'

class Product_Stock(models.Model):
    id = models.BigAutoField(primary_key=True)
    quanty = models.BigIntegerField(blank=True, null=True)
    product_name = models.CharField(max_length=150, blank=True, null=True)
    product_description = models.CharField(max_length=200, blank=True, null=True)
    brand_name = models.CharField(max_length=100, blank=True, null=True)
    img_url = models.CharField(max_length=250, blank=True, null=True)
    unit_list_price = models.BigIntegerField(blank=True, null=True)
    unit_sell_price = models.BigIntegerField(blank=True, null=True)
    
    class Meta:
        managed = False
        db_table = 'product_stock'        


class Sex(models.Model):
    id = models.BigAutoField(primary_key=True)
    sex_name = models.CharField(max_length=80, blank=True, null=True)
    sex_detail = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'sex'


class States(models.Model):
    id = models.BigAutoField(primary_key=True)
    state_name = models.CharField(max_length=100, blank=True, null=True)
    state_numeric = models.CharField(max_length=3, blank=True, null=True)
    state_detail = models.CharField(max_length=250, blank=True, null=True)
    country_code = models.ForeignKey(Country, models.DO_NOTHING, db_column='country_code', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'states'


class Stock(models.Model):
    supplier_code = models.OneToOneField('Supplier', models.DO_NOTHING, db_column='supplier_code', primary_key=True)
    product_code = models.ForeignKey(Product, models.DO_NOTHING, db_column='product_code')
    buy_date = models.DateField()
    unit_cost_price = models.BigIntegerField(blank=True, null=True)
    unit_list_price = models.BigIntegerField(blank=True, null=True)
    unit_sell_price = models.BigIntegerField(blank=True, null=True)
    sell_price = models.BigIntegerField(blank=True, null=True)
    quanty_buy = models.BigIntegerField(blank=True, null=True)
    quanty = models.BigIntegerField(blank=True, null=True)
    active = models.BooleanField()


class Supplier(models.Model):
    id = models.BigAutoField(primary_key=True)
    supplier_name = models.CharField(max_length=150, blank=True, null=True)
    short_name = models.CharField(max_length=100, blank=True, null=True)
    supplier_phone = models.CharField(max_length=20, blank=True, null=True)
    supplier_email = models.CharField(max_length=80, blank=True, null=True)
    address_code = models.ForeignKey(AddressSupplier, models.DO_NOTHING, db_column='address_code', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'supplier'