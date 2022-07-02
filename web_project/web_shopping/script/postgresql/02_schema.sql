/* EXECUTE WITH web_shopping_bd USER  */
/*DROP TABLES SCHEMA DJANGO*/

DROP TABLE IF EXISTS auth_user_user_permissions;
DROP TABLE IF EXISTS auth_user_groups;
DROP TABLE IF EXISTS authtoken_token;
DROP TABLE IF EXISTS auth_group_permissions;
DROP TABLE IF EXISTS auth_permission;
DROP TABLE IF EXISTS django_admin_log;
DROP TABLE IF EXISTS auth_group;
DROP TABLE IF EXISTS auth_user;
DROP TABLE IF EXISTS django_content_type;
DROP TABLE IF EXISTS django_session;
DROP TABLE IF EXISTS django_migrations;

CREATE TABLE auth_group (
    id BIGSERIAL PRIMARY KEY,
    name varchar(150) NOT NULL UNIQUE
);

CREATE TABLE auth_user(
	id BIGSERIAL PRIMARY KEY,
	password varchar(128) NOT NULL,
	last_login	timestamp,
	is_superuser boolean NOT NULL,
	username varchar(150) NOT NULL UNIQUE,
	first_name varchar(150) NOT NULL,
	last_name varchar(150) NOT NULL,
	email varchar(254) NOT NULL,
	is_staff boolean NOT NULL,
	is_active boolean NOT NULL,
	date_joined timestamp
);

/* ADD USER admin WITH PASS admin*/
INSERT INTO auth_user (password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES
('pbkdf2_sha256$320000$qdBAYBozHfVYRtXzLY3hMp$sZD+L0yEbVW1FOCnBh48CDZxmA+xWcMnmQ4Epo9Ahk4=', NULL, true,
    'admin', 'Administrator', 'Administrator', 'admin@admin.cl', true, true, now());

SELECT COUNT(1) FROM auth_user;

CREATE TABLE django_content_type (
	id BIGSERIAL PRIMARY KEY,
	app_label varchar(100) NOT NULL,
	model varchar(100) NOT NULL,
   	CONSTRAINT django_content_type_app_label_model
	   UNIQUE (app_label, model)
);

INSERT INTO django_content_type (app_label, model) VALUES ('admin', 'logentry');
INSERT INTO django_content_type (app_label, model) VALUES ('auth', 'permission');
INSERT INTO django_content_type (app_label, model) VALUES ('auth', 'group');
INSERT INTO django_content_type (app_label, model) VALUES ('auth', 'user');
INSERT INTO django_content_type (app_label, model) VALUES ('contenttypes', 'contenttype');
INSERT INTO django_content_type (app_label, model) VALUES ('sessions', 'session');
INSERT INTO django_content_type (app_label, model) VALUES ('userapi', 'usuario');
INSERT INTO django_content_type (app_label, model) VALUES ('authtoken', 'token');
INSERT INTO django_content_type (app_label, model) VALUES ('authtoken', 'tokenproxy');
/* ADD CONTENT SCHEMA WEB_SHOPPING*/
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'billing_type');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'pay_method');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'stock');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'supplier');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'address_supplier');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'product');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'category');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'brand');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'person');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'sex');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'address');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'city');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'states');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'currency_converter');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'currency');
INSERT INTO django_content_type (app_label, model) VALUES ('web_shopping', 'country');

SELECT COUNT(1) FROM django_content_type;


CREATE TABLE django_admin_log (
	id BIGSERIAL PRIMARY KEY,
	action_time timestamp NOT NULL,
	object_id text,
	object_repr varchar(200) NOT NULL,
	action_flag smallint NOT NULL CHECK (action_flag > 0),
	change_message text NOT NULL,
	content_type_id bigint,
	user_id bigint,
   	CONSTRAINT fk_django_admin_log_content_type_id
    	FOREIGN KEY(content_type_id) 
	 	REFERENCES django_content_type(id),
    	FOREIGN KEY(user_id) 
	 	REFERENCES auth_user(id)
);

CREATE TABLE django_session (
    session_key varchar(40) PRIMARY KEY,
    session_data text NOT NULL,
    expire_date timestamp NOT NULL
);

CREATE TABLE django_migrations (
    id BIGSERIAL PRIMARY KEY,
    app varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    applied timestamp NOT NULL
);

INSERT INTO django_migrations (app, name, applied) VALUES ('contenttypes', '0001_initial', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0001_initial', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('admin', '0001_initial', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('admin', '0002_logentry_remove_auto_add', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('admin', '0003_logentry_add_action_flag_choices', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('contenttypes', '0002_remove_content_type_name', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0002_alter_permission_name_max_length', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0003_alter_user_email_max_length', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0004_alter_user_username_opts', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0005_alter_user_last_login_null', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0006_require_contenttypes_0002', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0007_alter_validators_add_error_messages', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0008_alter_user_username_max_length', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0009_alter_user_last_name_max_length', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0010_alter_group_name_max_length', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0011_update_proxy_permissions', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('auth', '0012_alter_user_first_name_max_length', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('sessions', '0001_initial', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('authtoken', '0001_initial', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('authtoken', '0002_auto_20160226_1747', now());
INSERT INTO django_migrations (app, name, applied) VALUES ('authtoken', '0003_tokenproxy', now());

CREATE TABLE auth_permission (
    id BIGSERIAL PRIMARY KEY,
    name varchar(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename varchar(100) NOT NULL,
   	CONSTRAINT auth_permission_content_type_id_codename
	   UNIQUE (content_type_id, codename),
   	CONSTRAINT auth_permission_content_type_id
    	FOREIGN KEY(content_type_id) 
	 	REFERENCES django_content_type(id)
);

INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add log entry', 1, 'add_logentry');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change log entry', 1, 'change_logentry');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete log entry', 1, 'delete_logentry');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view log entry', 1, 'view_logentry');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add permission', 2, 'add_permission');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change permission', 2, 'change_permission');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete permission', 2, 'delete_permission');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view permission', 2, 'view_permission');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add group', 3, 'add_group');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change group', 3, 'change_group');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete group', 3, 'delete_group');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view group', 3, 'view_group');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add user', 4, 'add_user');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change user', 4, 'change_user');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete user', 4, 'delete_user');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view user', 4, 'view_user');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add content type', 5, 'add_contenttype');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change content type', 5, 'change_contenttype');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete content type', 5, 'delete_contenttype');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view content type', 5, 'view_contenttype');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add session', 6, 'add_session');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change session', 6, 'change_session');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete session', 6, 'delete_session');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view session', 6, 'view_session');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add usuario', 7, 'add_usuario');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change usuario', 7, 'change_usuario');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete usuario', 7, 'delete_usuario');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view usuario', 7, 'view_usuario');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add Token', 8, 'add_token');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change Token', 8, 'change_token');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete Token', 8, 'delete_token');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view Token', 8, 'view_token');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add token', 9, 'add_tokenproxy');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change token', 9, 'change_tokenproxy');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete token', 9, 'delete_tokenproxy');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view token', 9, 'view_tokenproxy');
/* ADD PERMISSION WEB_SHOPPING */
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can add Country', 
    (select id FROM django_content_type WHERE app_label = 'web_shopping' and model = 'country'), 'add_country');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can delete country', 
    (select id FROM django_content_type WHERE app_label = 'web_shopping' and model = 'country'), 'delete_country');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can view country', 
    (select id FROM django_content_type WHERE app_label = 'web_shopping' and model = 'country'), 'view_country');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('Can change countrty', 
    (select id FROM django_content_type WHERE app_label = 'web_shopping' and model = 'country'), 'change_country');

SELECT COUNT(1) FROM auth_permission;


CREATE TABLE auth_group_permissions (
    id BIGSERIAL PRIMARY KEY,
    group_id bigint NOT NULL,
    permission_id bigint NOT NULL,
   	CONSTRAINT auth_group_permissions_group_id_permission_id
	   UNIQUE (group_id, permission_id),
   	CONSTRAINT auth_group_permissions_group_id
    	FOREIGN KEY(group_id) 
	 	REFERENCES auth_group(id),
   	CONSTRAINT auth_group_permissions_auth_permission
    	FOREIGN KEY(permission_id) 
	 	REFERENCES auth_permission(id)     
);

CREATE TABLE auth_user_groups (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id bigint NOT NULL,
    group_id bigint NOT NULL,
    CONSTRAINT auth_user_groups_user_id_group_id UNIQUE (user_id, group_id),
   	CONSTRAINT auth_user_groups_user_id
    	FOREIGN KEY(user_id) 
	 	REFERENCES auth_user(id),
   	CONSTRAINT auth_user_groups_group_id
    	FOREIGN KEY(group_id) 
	 	REFERENCES auth_group(id)
);

CREATE TABLE authtoken_token (
    key varchar(40) PRIMARY KEY,
    created timestamp NOT NULL,
    user_id bigint NOT NULL,
    CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id),
   	CONSTRAINT authtoken_token_user_id
    	FOREIGN KEY(user_id) 
	 	REFERENCES auth_user(id)
);

CREATE TABLE auth_user_user_permissions (
    id BIGSERIAL PRIMARY KEY,
    user_id bigint NOT NULL,
    permission_id bigint NOT NULL,
    CONSTRAINT auth_user_user_permissions_user_id_permission_id UNIQUE (user_id, permission_id),
   	CONSTRAINT auth_user_user_permissions_permission_id
    	FOREIGN KEY(permission_id) 
	 	REFERENCES auth_permission(id),
   	CONSTRAINT auth_user_user_permissions_user_id
    	FOREIGN KEY(user_id) 
	 	REFERENCES auth_user(id)
);


/*DROP TABLES SCHEMA WEB SHOPPING*/
DROP TABLE IF EXISTS billing_type;
DROP TABLE IF EXISTS pay_method;
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS address_supplier;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS brand;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS sex;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS states;
DROP TABLE IF EXISTS currency_converter;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS country;

/*CREATE TABLE COUNTRY*/
create table country (
	id BIGSERIAL PRIMARY KEY,
	country_name varchar(100),	
	alpha2_code varchar(2),
	alpha3_code varchar(3),
	numeric_country varchar(3),
	country_detail varchar(250)
);

/*INSERT COUNTRY DATA*/
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Afghanistan','AF','AFG','4');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Albania','AL','ALB','8');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Algeria','DZ','DZA','12');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('American Samoa','AS','ASM','16');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Andorra','AD','AND','20');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Angola','AO','AGO','24');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Anguilla','AI','AIA','660');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Antarctica','AQ','ATA','10');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Antigua and Barbuda','AG','ATG','28');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Argentina','AR','ARG','32');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Armenia','AM','ARM','51');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Aruba','AW','ABW','533');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Australia','AU','AUS','36');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Austria','AT','AUT','40');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Azerbaijan','AZ','AZE','31');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bahamas (the)','BS','BHS','44');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bahrain','BH','BHR','48');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bangladesh','BD','BGD','50');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Barbados','BB','BRB','52');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Belarus','BY','BLR','112');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Belgium','BE','BEL','56');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Belize','BZ','BLZ','84');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Benin','BJ','BEN','204');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bermuda','BM','BMU','60');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bhutan','BT','BTN','64');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bolivia (Plurinational State of)','BO','BOL','68');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bonaire, Sint Eustatius and Saba','BQ','BES','535');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bosnia and Herzegovina','BA','BIH','70');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Botswana','BW','BWA','72');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bouvet Island','BV','BVT','74');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Brazil','BR','BRA','76');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('British Indian Ocean Territory (the)','IO','IOT','86');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Brunei Darussalam','BN','BRN','96');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Bulgaria','BG','BGR','100');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Burkina Faso','BF','BFA','854');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Burundi','BI','BDI','108');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cabo Verde','CV','CPV','132');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cambodia','KH','KHM','116');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cameroon','CM','CMR','120');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Canada','CA','CAN','124');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cayman Islands (the)','KY','CYM','136');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Central African Republic (the)','CF','CAF','140');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Chad','TD','TCD','148');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Chile','CL','CHL','152');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('China','CN','CHN','156');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Christmas Island','CX','CXR','162');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cocos (Keeling) Islands (the)','CC','CCK','166');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Colombia','CO','COL','170');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Comoros (the)','KM','COM','174');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Congo (the Democratic Republic of the)','CD','COD','180');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Congo (the)','CG','COG','178');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cook Islands (the)','CK','COK','184');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Costa Rica','CR','CRI','188');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Croatia','HR','HRV','191');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cuba','CU','CUB','192');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Curaçao','CW','CUW','531');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Cyprus','CY','CYP','196');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Czechia','CZ','CZE','203');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Côte d''Ivoire','CI','CIV','384');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Denmark','DK','DNK','208');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Djibouti','DJ','DJI','262');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Dominica','DM','DMA','212');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Dominican Republic (the)','DO','DOM','214');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Ecuador','EC','ECU','218');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Egypt','EG','EGY','818');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('El Salvador','SV','SLV','222');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Equatorial Guinea','GQ','GNQ','226');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Eritrea','ER','ERI','232');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Estonia','EE','EST','233');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Eswatini','SZ','SWZ','748');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Ethiopia','ET','ETH','231');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Falkland Islands (the) [Malvinas]','FK','FLK','238');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Faroe Islands (the)','FO','FRO','234');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Fiji','FJ','FJI','242');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Finland','FI','FIN','246');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('France','FR','FRA','250');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('French Guiana','GF','GUF','254');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('French Polynesia','PF','PYF','258');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('French Southern Territories (the)','TF','ATF','260');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Gabon','GA','GAB','266');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Gambia (the)','GM','GMB','270');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Georgia','GE','GEO','268');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Germany','DE','DEU','276');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Ghana','GH','GHA','288');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Gibraltar','GI','GIB','292');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Greece','GR','GRC','300');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Greenland','GL','GRL','304');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Grenada','GD','GRD','308');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Guadeloupe','GP','GLP','312');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Guam','GU','GUM','316');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Guatemala','GT','GTM','320');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Guernsey','GG','GGY','831');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Guinea','GN','GIN','324');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Guinea-Bissau','GW','GNB','624');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Guyana','GY','GUY','328');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Haiti','HT','HTI','332');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Heard Island and McDonald Islands','HM','HMD','334');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Holy See (the)','VA','VAT','336');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Honduras','HN','HND','340');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Hong Kong','HK','HKG','344');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Hungary','HU','HUN','348');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Iceland','IS','ISL','352');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('India','IN','IND','356');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Indonesia','ID','IDN','360');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Iran (Islamic Republic of)','IR','IRN','364');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Iraq','IQ','IRQ','368');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Ireland','IE','IRL','372');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Isle of Man','IM','IMN','833');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Israel','IL','ISR','376');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Italy','IT','ITA','380');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Jamaica','JM','JAM','388');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Japan','JP','JPN','392');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Jersey','JE','JEY','832');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Jordan','JO','JOR','400');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Kazakhstan','KZ','KAZ','398');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Kenya','KE','KEN','404');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Kiribati','KI','KIR','296');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Korea (the Democratic People''s Republic of)','KP','PRK','408');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Korea (the Republic of)','KR','KOR','410');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Kuwait','KW','KWT','414');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Kyrgyzstan','KG','KGZ','417');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Lao People''s Democratic Republic (the)','LA','LAO','418');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Latvia','LV','LVA','428');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Lebanon','LB','LBN','422');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Lesotho','LS','LSO','426');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Liberia','LR','LBR','430');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Libya','LY','LBY','434');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Liechtenstein','LI','LIE','438');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Lithuania','LT','LTU','440');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Luxembourg','LU','LUX','442');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Macao','MO','MAC','446');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Madagascar','MG','MDG','450');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Malawi','MW','MWI','454');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Malaysia','MY','MYS','458');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Maldives','MV','MDV','462');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Mali','ML','MLI','466');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Malta','MT','MLT','470');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Marshall Islands (the)','MH','MHL','584');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Martinique','MQ','MTQ','474');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Mauritania','MR','MRT','478');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Mauritius','MU','MUS','480');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Mayotte','YT','MYT','175');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Mexico','MX','MEX','484');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Micronesia (Federated States of)','FM','FSM','583');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Moldova (the Republic of)','MD','MDA','498');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Monaco','MC','MCO','492');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Mongolia','MN','MNG','496');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Montenegro','ME','MNE','499');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Montserrat','MS','MSR','500');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Morocco','MA','MAR','504');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Mozambique','MZ','MOZ','508');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Myanmar','MM','MMR','104');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Namibia','NA','NAM','516');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Nauru','NR','NRU','520');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Nepal','NP','NPL','524');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Netherlands (the)','NL','NLD','528');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('New Caledonia','NC','NCL','540');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('New Zealand','NZ','NZL','554');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Nicaragua','NI','NIC','558');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Niger (the)','NE','NER','562');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Nigeria','NG','NGA','566');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Niue','NU','NIU','570');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Norfolk Island','NF','NFK','574');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Northern Mariana Islands (the)','MP','MNP','580');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Norway','NO','NOR','578');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Oman','OM','OMN','512');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Pakistan','PK','PAK','586');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Palau','PW','PLW','585');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Palestine, State of','PS','PSE','275');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Panama','PA','PAN','591');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Papua New Guinea','PG','PNG','598');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Paraguay','PY','PRY','600');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Peru','PE','PER','604');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Philippines (the)','PH','PHL','608');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Pitcairn','PN','PCN','612');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Poland','PL','POL','616');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Portugal','PT','PRT','620');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Puerto Rico','PR','PRI','630');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Qatar','QA','QAT','634');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Republic of North Macedonia','MK','MKD','807');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Romania','RO','ROU','642');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Russian Federation (the)','RU','RUS','643');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Rwanda','RW','RWA','646');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Réunion','RE','REU','638');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saint Barthélemy','BL','BLM','652');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saint Helena, Ascension and Tristan da Cunha','SH','SHN','654');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saint Kitts and Nevis','KN','KNA','659');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saint Lucia','LC','LCA','662');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saint Martin (French part)','MF','MAF','663');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saint Pierre and Miquelon','PM','SPM','666');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saint Vincent and the Grenadines','VC','VCT','670');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Samoa','WS','WSM','882');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('San Marino','SM','SMR','674');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Sao Tome and Principe','ST','STP','678');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Saudi Arabia','SA','SAU','682');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Senegal','SN','SEN','686');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Serbia','RS','SRB','688');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Seychelles','SC','SYC','690');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Sierra Leone','SL','SLE','694');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Singapore','SG','SGP','702');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Sint Maarten (Dutch part)','SX','SXM','534');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Slovakia','SK','SVK','703');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Slovenia','SI','SVN','705');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Solomon Islands','SB','SLB','90');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Somalia','SO','SOM','706');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('South Africa','ZA','ZAF','710');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('South Georgia and the South Sandwich Islands','GS','SGS','239');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('South Sudan','SS','SSD','728');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Spain','ES','ESP','724');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Sri Lanka','LK','LKA','144');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Sudan (the)','SD','SDN','729');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Suriname','SR','SUR','740');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Svalbard and Jan Mayen','SJ','SJM','744');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Sweden','SE','SWE','752');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Switzerland','CH','CHE','756');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Syrian Arab Republic','SY','SYR','760');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Taiwan (Province of China)','TW','TWN','158');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Tajikistan','TJ','TJK','762');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Tanzania, United Republic of','TZ','TZA','834');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Thailand','TH','THA','764');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Timor-Leste','TL','TLS','626');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Togo','TG','TGO','768');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Tokelau','TK','TKL','772');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Tonga','TO','TON','776');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Trinidad and Tobago','TT','TTO','780');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Tunisia','TN','TUN','788');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Turkey','TR','TUR','792');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Turkmenistan','TM','TKM','795');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Turks and Caicos Islands (the)','TC','TCA','796');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Tuvalu','TV','TUV','798');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Uganda','UG','UGA','800');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Ukraine','UA','UKR','804');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('United Arab Emirates (the)','AE','ARE','784');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('United Kingdom of Great Britain and Northern Ireland (the)','GB','GBR','826');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('United States Minor Outlying Islands (the)','UM','UMI','581');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('United States of America (the)','US','USA','840');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Uruguay','UY','URY','858');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Uzbekistan','UZ','UZB','860');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Vanuatu','VU','VUT','548');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Venezuela (Bolivarian Republic of)','VE','VEN','862');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Viet Nam','VN','VNM','704');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Virgin Islands (British)','VG','VGB','92');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Virgin Islands (U.S.)','VI','VIR','850');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Wallis and Futuna','WF','WLF','876');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Western Sahara','EH','ESH','732');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Yemen','YE','YEM','887');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Zambia','ZM','ZMB','894');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Zimbabwe','ZW','ZWE','716');
INSERT INTO country (country_name, alpha2_code, alpha3_code, numeric_country) VALUES ('Åland Islands','AX','ALA','248');

SELECT * FROM country;
/*******************************************************************************************************************************/

/*CREATE TABLE STATES*/

create table states (
	id BIGSERIAL PRIMARY KEY,
	state_name varchar(100),	
	state_numeric varchar(3),
	state_detail varchar(250),
	country_code bigint,
   	CONSTRAINT fk_states_country_id
    	FOREIGN KEY(country_code) 
	 	REFERENCES country(id)	
);

/*INSERT STATES DATA*/
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Tarapacá', '01', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Antofagasta', '02', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Atacama', '03', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Coquimbo', '04', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Valparaíso', '05', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Libertador General Bernardo O’Higgins', '06', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Maule', '07', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Biobío', '08', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('La Araucanía', '09', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Los Lagos', '10', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Aysén del General Carlos Ibáñez del Campo', '11', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Magallanes y de la Antártica Chilena', '12', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Metropolitana de Santiago', '13', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Los Ríos', '14', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Arica y Parinacota', '15', '', (SELECT id FROM country WHERE country_name = 'Chile'));
INSERT INTO states (state_name, state_numeric, state_detail, country_code) VALUES ('Ñuble', '16', '', (SELECT id FROM country WHERE country_name = 'Chile'));

SELECT * FROM states;
/*******************************************************************************************************************************/

/*CREATE TABLE CITIES*/
create table city (
	id BIGSERIAL PRIMARY KEY,
	city_name varchar(100),	
	city_numeric varchar(6),
	city_detail varchar(250),
	state_code bigint,
   	CONSTRAINT fk_city_states_id
    	FOREIGN KEY(state_code) 
	 	REFERENCES states(id)		
);

/*INSERT CITIES DATA*/
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Iquique','1101','',(SELECT id FROM states WHERE state_name='Tarapacá'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Alto Hospicio','1107','',(SELECT id FROM states WHERE state_name='Tarapacá'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pozo Almonte','1401','',(SELECT id FROM states WHERE state_name='Tarapacá'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Camiña','1402','',(SELECT id FROM states WHERE state_name='Tarapacá'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Colchane','1403','',(SELECT id FROM states WHERE state_name='Tarapacá'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Huara','1404','',(SELECT id FROM states WHERE state_name='Tarapacá'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pica','1405','',(SELECT id FROM states WHERE state_name='Tarapacá'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Antofagasta','2101','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Mejillones','2102','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Sierra Gorda','2103','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Taltal','2104','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Calama','2201','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ollagüe','2202','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Pedro de Atacama','2203','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Tocopilla','2301','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('María Elena','2302','',(SELECT id FROM states WHERE state_name='Antofagasta'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Copiapó','3101','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Caldera','3102','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Tierra Amarilla','3103','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chañaral','3201','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Diego de Almagro','3202','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Vallenar','3301','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Alto del Carmen','3302','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Freirina','3303','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Huasco','3304','',(SELECT id FROM states WHERE state_name='Atacama'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Serena','4101','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Coquimbo','4102','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Andacollo','4103','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Higuera','4104','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Paiguano','4105','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Vicuña','4106','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Illapel','4201','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Canela','4202','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Los Vilos','4203','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Salamanca','4204','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ovalle','4301','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Combarbalá','4302','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Monte Patria','4303','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Punitaqui','4304','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Río Hurtado','4305','',(SELECT id FROM states WHERE state_name='Coquimbo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Valparaíso','5101','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Casablanca','5102','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Concón','5103','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Juan Fernández','5104','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Puchuncaví','5105','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quintero','5107','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Viña del Mar','5109','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Isla de Pascua','5201','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Los Andes','5301','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Calle Larga','5302','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Rinconada','5303','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Esteban','5304','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Ligua','5401','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cabildo','5402','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Papudo','5403','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Petorca','5404','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Zapallar','5405','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quillota','5501','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Calera','5502','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Hijuelas','5503','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Cruz','5504','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Nogales','5506','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Antonio','5601','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Algarrobo','5602','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cartagena','5603','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('El Quisco','5604','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('El Tabo','5605','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Santo Domingo','5606','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Felipe','5701','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Catemu','5702','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Llaillay','5703','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Panquehue','5704','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Putaendo','5705','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Santa María','5706','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quilpué','5801','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Limache','5802','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Olmué','5803','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Villa Alemana','5804','',(SELECT id FROM states WHERE state_name='Valparaíso'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Rancagua','6101','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Codegua','6102','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Coinco','6103','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Coltauco','6104','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Doñihue','6105','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Graneros','6106','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Las Cabras','6107','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Machalí','6108','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Malloa','6109','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Mostazal','6110','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Olivar','6111','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Peumo','6112','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pichidegua','6113','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quinta de Tilcoco','6114','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Rengo','6115','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Requínoa','6116','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Vicente','6117','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pichilemu','6201','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Estrella','6202','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Litueche','6203','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Marchihue','6204','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Navidad','6205','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Paredones','6206','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Fernando','6301','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chépica','6302','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chimbarongo','6303','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lolol','6304','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Nancagua','6305','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Palmilla','6306','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Peralillo','6307','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Placilla','6308','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pumanque','6309','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Santa Cruz','6310','',(SELECT id FROM states WHERE state_name='Libertador General Bernardo O’Higgins'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Talca','7101','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Constitución','7102','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Curepto','7103','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Empedrado','7104','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Maule','7105','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pelarco','7106','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pencahue','7107','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Río Claro','7108','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Clemente','7109','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Rafael','7110','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cauquenes','7201','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chanco','7202','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pelluhue','7203','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Curicó','7301','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Hualañé','7302','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Licantén','7303','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Molina','7304','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Rauco','7305','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Romeral','7306','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Sagrada Familia','7307','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Teno','7308','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Vichuquén','7309','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Linares','7401','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Colbún','7402','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Longaví','7403','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Parral','7404','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Retiro','7405','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Javier','7406','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Villa Alegre','7407','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Yerbas Buenas','7408','',(SELECT id FROM states WHERE state_name='Maule'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Concepción','8101','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Coronel','8102','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chiguayante','8103','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Florida','8104','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Hualqui','8105','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lota','8106','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Penco','8107','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Pedro de la Paz','8108','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Santa Juana','8109','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Talcahuano','8110','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Tomé','8111','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Hualpén','8112','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lebu','8201','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Arauco','8202','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cañete','8203','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Contulmo','8204','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Curanilahue','8205','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Los Alamos','8206','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Tirúa','8207','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Los Angeles','8301','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Antuco','8302','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cabrero','8303','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Laja','8304','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Mulchén','8305','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Nacimiento','8306','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Negrete','8307','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quilaco','8308','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quilleco','8309','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Rosendo','8310','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Santa Bárbara','8311','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Tucapel','8312','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Yumbel','8313','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Alto Biobío','8314','',(SELECT id FROM states WHERE state_name='Biobío'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Temuco','9101','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Carahue','9102','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cunco','9103','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Curarrehue','9104','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Freire','9105','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Galvarino','9106','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Gorbea','9107','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lautaro','9108','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Loncoche','9109','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Melipeuco','9110','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Nueva Imperial','9111','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Padre Las Casas','9112','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Perquenco','9113','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pitrufquén','9114','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pucón','9115','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Saavedra','9116','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Teodoro Schmidt','9117','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Toltén','9118','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Vilcún','9119','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Villarrica','9120','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cholchol','9121','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Angol','9201','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Collipulli','9202','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Curacautín','9203','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ercilla','9204','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lonquimay','9205','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Los Sauces','9206','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lumaco','9207','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Purén','9208','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Renaico','9209','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Traiguén','9210','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Victoria','9211','',(SELECT id FROM states WHERE state_name='La Araucanía'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Puerto Montt','10101','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Calbuco','10102','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cochamó','10103','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Fresia','10104','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Frutillar','10105','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Los Muermos','10106','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Llanquihue','10107','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Maullín','10108','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Puerto Varas','10109','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Castro','10201','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ancud','10202','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chonchi','10203','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Curaco de Vélez','10204','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Dalcahue','10205','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Puqueldón','10206','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Queilén','10207','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quellón','10208','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quemchi','10209','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quinchao','10210','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Osorno','10301','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Puerto Octay','10302','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Purranque','10303','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Puyehue','10304','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Río Negro','10305','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Juan de la Costa','10306','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Pablo','10307','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chaitén','10401','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Futaleufú','10402','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Hualaihué','10403','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Palena','10404','',(SELECT id FROM states WHERE state_name='Los Lagos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Coihaique','11101','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lago Verde','11102','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Aisén','11201','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cisnes','11202','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Guaitecas','11203','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cochrane','11301','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('O''Higgins','11302','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Tortel','11303','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chile Chico','11401','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Río Ibáñez','11402','',(SELECT id FROM states WHERE state_name='Aysén del General Carlos Ibáñez del Campo'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Punta Arenas','12101','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Laguna Blanca','12102','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Río Verde','12103','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Gregorio','12104','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cabo de Hornos','12201','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Antártica','12202','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Porvenir','12301','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Primavera','12302','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Timaukel','12303','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Natales','12401','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Torres del Paine','12402','',(SELECT id FROM states WHERE state_name='Magallanes y de la Antártica Chilena'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Santiago','13101','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cerrillos','13102','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cerro Navia','13103','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Conchalí','13104','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('El Bosque','13105','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Estación Central','13106','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Huechuraba','13107','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Independencia','13108','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Cisterna','13109','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Florida','13110','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Granja','13111','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Pintana','13112','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Reina','13113','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Las Condes','13114','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lo Barnechea','13115','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lo Espejo','13116','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lo Prado','13117','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Macul','13118','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Maipú','13119','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ñuñoa','13120','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pedro Aguirre Cerda','13121','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Peñalolén','13122','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Providencia','13123','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pudahuel','13124','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quilicura','13125','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quinta Normal','13126','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Recoleta','13127','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Renca','13128','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Joaquín','13129','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Miguel','13130','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Ramón','13131','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Vitacura','13132','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Puente Alto','13201','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pirque','13202','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San José de Maipo','13203','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Colina','13301','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lampa','13302','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Tiltil','13303','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Bernardo','13401','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Buin','13402','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Calera de Tango','13403','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Paine','13404','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Melipilla','13501','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Alhué','13502','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Curacaví','13503','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('María Pinto','13504','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Pedro','13505','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Talagante','13601','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('El Monte','13602','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Isla de Maipo','13603','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Padre Hurtado','13604','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Peñaflor','13605','',(SELECT id FROM states WHERE state_name='Metropolitana de Santiago'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Valdivia','14101','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Corral','14102','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lanco','14103','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Los Lagos','14104','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Máfil','14105','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Mariquina','14106','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Paillaco','14107','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Panguipulli','14108','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('La Unión','14201','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Futrono','14202','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Lago Ranco','14203','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Río Bueno','14204','',(SELECT id FROM states WHERE state_name='Los Ríos'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Arica','15101','',(SELECT id FROM states WHERE state_name='Arica y Parinacota'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Camarones','15102','',(SELECT id FROM states WHERE state_name='Arica y Parinacota'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Putre','15201','',(SELECT id FROM states WHERE state_name='Arica y Parinacota'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('General Lagos','15202','',(SELECT id FROM states WHERE state_name='Arica y Parinacota'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chillán','16101','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Bulnes','16102','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Chillán Viejo','16103','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('El Carmen','16104','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pemuco','16105','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Pinto','16106','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quillón','16107','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Ignacio','16108','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Yungay','16109','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Quirihue','16201','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Cobquecura','16202','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Coelemu','16203','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ninhue','16204','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Portezuelo','16205','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ranquil','16206','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Treguaco','16207','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Carlos','16301','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Coihueco','16302','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('Ñiquén','16303','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Fabián','16304','',(SELECT id FROM states WHERE state_name='Ñuble'));
INSERT INTO city (city_name, city_numeric, city_detail,state_code) VALUES('San Nicolás','16305','',(SELECT id FROM states WHERE state_name='Ñuble'));

UPDATE city SET city_numeric = '0'||city_numeric WHERE  CHAR_LENGTH(city_numeric) < 5;

SELECT * FROM city;
/*******************************************************************************************************************************/

/*CREATE TABLE CURRENCY*/
create table currency (
	id BIGSERIAL PRIMARY KEY,
	currency_name varchar(120),
	symbol varchar,	
	country_code bigint,
   	CONSTRAINT fk_currency_country_id
    	FOREIGN KEY(country_code) 
	 	REFERENCES country(id)		
);

/*INSERT CURRENCY DATA*/
INSERT INTO currency (currency_name, symbol, country_code) VALUES ('US Dolar', 'US$', (SELECT id FROM country WHERE country_name = 'United States of America (the)'));
INSERT INTO currency (currency_name, symbol, country_code) VALUES ('Chilean Peso', 'CLP', (SELECT id FROM country WHERE country_name = 'Chile'));

SELECT * FROM currency;
/*******************************************************************************************************************************/

/*CREATE TABLE CURRENCY_CONVERTER*/
create table currency_converter (
	from_currency_code bigint,
	to_currency_code bigint,
	currency_day date not null,
	amount numeric not null,
   	CONSTRAINT fk_currency_con_from_currency_id
    	FOREIGN KEY(from_currency_code) 
	 	REFERENCES currency(id),
   	CONSTRAINT fk_currency_con_to_currency_id
    	FOREIGN KEY(to_currency_code) 
	 	REFERENCES currency(id),
	PRIMARY KEY (from_currency_code, to_currency_code, currency_day)
);

/*INSERT CURRENCY_CONVERTER DATA*/
INSERT INTO currency_converter (from_currency_code, to_currency_code, currency_day, amount) VALUES ((SELECT id FROM currency WHERE currency_name = 'US Dolar'), 
									   (SELECT id FROM currency WHERE currency_name = 'Chilean Peso'), '02-06-2022', 815.03);
					
SELECT * FROM currency_converter;
/*******************************************************************************************************************************/	

/*CREATE TABLE ADDRESS*/

create table address (
	id BIGSERIAL PRIMARY KEY,
	street_name varchar(100),
	street_number varchar(15),
	postal_code varchar(20),
	latitude numeric,
	longitude numeric,
	altitude numeric,
	city_code bigint,
   	CONSTRAINT fk_address_city_id
    	FOREIGN KEY(city_code) 
	 	REFERENCES city(id)		
);

/*INSERT ADDRESS DATA*/

INSERT INTO address (street_name, street_number, postal_code, latitude, longitude, altitude, city_code) VALUES
	('Dieciocho', '158', '92500009', -33.4483136, -70.6600896, 17, (SELECT id FROM city WHERE city_name = 'Santiago'));
	
INSERT INTO address (street_name, street_number, postal_code, latitude, longitude, altitude, city_code) VALUES
	('Dieciocho', '190', '92500009', -33.4490422, -70.6598648, 17, (SELECT id FROM city WHERE city_name = 'Santiago'));	
	
SELECT * FROM address;
/*******************************************************************************************************************************/	

/*CREATE TABLE SEX*/

create table sex(
	id BIGSERIAL PRIMARY KEY,
	sex_name	varchar(80),
	sex_detail varchar(200)
);

/*INSERT SEX DATA*/

INSERT INTO sex (sex_name, sex_detail) VALUES ('male', ''); 
INSERT INTO sex (sex_name, sex_detail) VALUES ('female', ''); 
INSERT INTO sex (sex_name, sex_detail) VALUES ('undefined', ''); 

SELECT * FROM sex;
/*******************************************************************************************************************************/	

/*CREATE TABLE PERSON*/

create table person(
	id BIGSERIAL PRIMARY KEY,
	person_name	varchar(150),
	last_name varchar(150),
	second_last_name varchar(150),
	birdthday date,
	person_phone varchar(20),
	person_email varchar(80),
	address_code bigint,
	national_identification varchar(60),
	sex_code BIGINT,
   	CONSTRAINT fk_person_address_id
    	FOREIGN KEY(address_code) 
	 	REFERENCES address(id),
   	CONSTRAINT fk_person_sex_id
    	FOREIGN KEY(sex_code) 
	 	REFERENCES sex(id)
);

/*INSERT PERSON DATA*/

INSERT INTO person (person_name, last_name, second_last_name, birdthday, person_phone, person_email, address_code, national_identification, sex_code) 
VALUES ('Maria', 'Tapia', 'Solis', '05-05-1990', '+569 5555 5555', 'mtapiasolis@gmail.com', 
		(SELECT id FROM address WHERE street_name = 'Dieciocho' AND street_number = '158'),
	    (SELECT id FROM country WHERE country_name = 'Chile'), (SELECT id FROM sex WHERE sex_name = 'female')); 
		
INSERT INTO person (person_name, last_name, second_last_name, birdthday, person_phone, person_email, address_code, national_identification, sex_code) 
VALUES ('José', 'Henriquez', 'Cabrera', '01-01-1978', '+569 4444 4444', 'jhenriquezcabrera@gmail.com', 
		(SELECT id FROM address WHERE street_name = 'Dieciocho' AND street_number = '190'),
	    (SELECT id FROM country WHERE country_name = 'Chile'), (SELECT id FROM sex WHERE sex_name = 'female')); 		

SELECT * FROM person;

/*******************************************************************************************************************************/	

/*CREATE TABLE BRAND*/

create table brand (
	id BIGSERIAL PRIMARY KEY,
	brand_name varchar(100),	
	brand_description varchar(200)
);

/*INSERT BRAND DATA*/

INSERT INTO brand (brand_name, brand_description) VALUES ('Colun', ''); 
INSERT INTO brand (brand_name, brand_description) VALUES ('Soprole', ''); 
INSERT INTO brand (brand_name, brand_description) VALUES ('Surlat', ''); 

SELECT * FROM brand;

/*******************************************************************************************************************************/	

/*CREATE TABLE CATEGORY*/

create table category (
	id BIGSERIAL PRIMARY KEY,
	category_name varchar(100),	
	category_description varchar(200)
);

/*INSERT CATEGORY DATA*/

INSERT INTO category (category_name, category_description) VALUES ('dairy products', ''); 

SELECT * FROM category;

/*******************************************************************************************************************************/	

/*CREATE TABLE PRODUCT*/

create table product (
	id BIGSERIAL PRIMARY KEY,
	product_name varchar(150),
	product_description varchar(200),
	brand_code BIGINT,	
	category_code BIGINT,
    img_url varchar(250),
   	CONSTRAINT fk_product_brand_id
    	FOREIGN KEY(brand_code) 
	 	REFERENCES brand(id),
   	CONSTRAINT fk_product_category_id
    	FOREIGN KEY(category_code) 
	 	REFERENCES category(id)	
);

/*INSERT PRODUCT DATA*/

INSERT INTO product (product_name, product_description, brand_code, category_code, img_url) VALUES (
		'Leche Entera', '', 
		(SELECT id FROM brand WHERE brand_name = 'Colun'), (SELECT id FROM category WHERE category_name = 'dairy products'), 'img/product/colun/milk.jpeg'); 

INSERT INTO product (product_name, product_description, brand_code, category_code, img_url) VALUES (
		'Leche Entera', '', 
		(SELECT id FROM brand WHERE brand_name = 'Soprole'), (SELECT id FROM category WHERE category_name = 'dairy products'), 'img/product/soprole/milk.jpeg'); 
		
INSERT INTO product (product_name, product_description, brand_code, category_code, img_url) VALUES (
		'Leche Entera', '', 
		(SELECT id FROM brand WHERE brand_name = 'Surlat'), (SELECT id FROM category WHERE category_name = 'dairy products'), 'img/product/surlat/milk.jpeg'); 		
		
SELECT * FROM product;

/*******************************************************************************************************************************/	

/*CREATE TABLE ADDRESS_SUPPLIER*/

create table address_supplier (
	id BIGSERIAL PRIMARY KEY,
	street_name varchar(100),
	street_number varchar(15),
	postal_code varchar(20),
	latitude numeric,
	longitude numeric,
	altitude numeric,
	city_code bigint,
   	CONSTRAINT fk_address_city_id
    	FOREIGN KEY(city_code) 
	 	REFERENCES city(id)		
);

/*INSERT ADDRESS_SUPPLIER DATA*/

INSERT INTO address_supplier (street_name, street_number, postal_code, latitude, longitude, altitude, city_code) VALUES
	('Esmeralda', '641', '9855874416', -40.29564347731903, -73.08158066788864, 0, (SELECT id FROM city WHERE city_name = 'La Unión'));
	
INSERT INTO address_supplier (street_name, street_number, postal_code, latitude, longitude, altitude, city_code) VALUES
	('Av. Brasil', '650', '9855874416', -39.377444422680966, -72.6310395647464, 0, (SELECT id FROM city WHERE city_name = 'Loncoche'));
	
INSERT INTO address_supplier (street_name, street_number, postal_code, latitude, longitude, altitude, city_code) VALUES
	('Pdte Jorge Alessandri Rodríguez', '10800', '9855874416', -33.5521542, -70.7008917, 0, (SELECT id FROM city WHERE city_name = 'San Bernardo'));	
	

SELECT * FROM address_supplier;

/*******************************************************************************************************************************/	

create table supplier(
	id BIGSERIAL PRIMARY KEY,
	supplier_name	varchar(150),
    short_name  varchar(100),
	supplier_phone varchar(20),
	supplier_email varchar(80),
	address_code bigint,	
   	CONSTRAINT fk_address_supplier
    	FOREIGN KEY(address_code) 
	 	REFERENCES address_supplier(id)	
);

INSERT INTO supplier (supplier_name, short_name, supplier_phone, supplier_email, address_code) VALUES
('La Cooperativa Agrícola y Lechera de La Unión Limitada', 'Colun', '+569 8888 7777', 'colun@colun.cl', 
    (SELECT id FROM address_supplier WHERE street_name = 'Esmeralda' and street_number = '641'));
    
INSERT INTO supplier (supplier_name, short_name, supplier_phone, supplier_email, address_code) VALUES
('Sociedad de Productores de Leche', 'Soprole', '+569 8888 7777', 'soprole@soprole.cl', 
    (SELECT id FROM address_supplier WHERE street_name = 'Av. Brasil' and street_number = '650'));
    
INSERT INTO supplier (supplier_name, short_name, supplier_phone, supplier_email, address_code) VALUES
('Surlat S.A.', 'Surlat', '+569 8888 7777', 'surlat@surlat.cl', 
    (SELECT id FROM address_supplier WHERE street_name = 'Pdte Jorge Alessandri Rodríguez' and street_number = '10800'));
    
SELECT * FROM supplier;

create table stock(
	supplier_code bigint,	
	product_code bigint,	
	buy_date	date,
	unit_cost_price	bigint,
	unit_list_price bigint,
	unit_sell_price bigint,    
    sell_price bigint,
    quanty_buy bigint,
    quanty bigint,
    active boolean NOT NULL DEFAULT false,
	PRIMARY KEY (supplier_code, product_code, buy_date),
   	CONSTRAINT fk_stock_supplier_id
    	FOREIGN KEY(supplier_code) 
	 	REFERENCES supplier(id),
   	CONSTRAINT fk_stock_product_id
    	FOREIGN KEY(product_code) 
	 	REFERENCES product(id)		
);

INSERT INTO stock (supplier_code, product_code, buy_date, unit_cost_price, unit_list_price, unit_sell_price, quanty_buy, quanty, active) 
VALUES ((SELECT id FROM supplier WHERE short_name = 'Colun'),
    (select id from product where product_name='Leche Entera' and brand_code = (SELECT id FROM brand WHERE brand_name = 'Colun')), now(), 750, 1210, 1210, 550, 550, true);

INSERT INTO stock (supplier_code, product_code, buy_date, unit_cost_price, unit_list_price, unit_sell_price, quanty_buy, quanty, active) 
VALUES ((SELECT id FROM supplier WHERE short_name = 'Soprole'),
    (select id from product where product_name='Leche Entera' and brand_code = (SELECT id FROM brand WHERE brand_name = 'Soprole')), now(), 740, 1150, 1150, 550, 550, true);
    
INSERT INTO stock (supplier_code, product_code, buy_date, unit_cost_price, unit_list_price, unit_sell_price, quanty_buy, quanty, active) 
VALUES ((SELECT id FROM supplier WHERE short_name = 'Surlat'),
    (select id from product where product_name='Leche Entera' and brand_code = (SELECT id FROM brand WHERE brand_name = 'Surlat')), now(), 745, 1180, 1180, 550, 550, true);    

SELECT * FROM stock;

CREATE OR REPLACE VIEW product_stock as
SELECT  pro.id, st.quanty, pro.product_name, pro.product_description, br.brand_name,
        pro.img_url, st.unit_list_price, st.unit_sell_price
FROM product pro
JOIN stock st on st.product_code = pro.id
JOIN brand br on br.id = pro.brand_code
WHERE st.active = true;
        
create table billing_type (
	id BIGSERIAL PRIMARY KEY,
	billing_name 	varchar(100),
	billing_detail	varchar(200)
);

INSERT INTO billing_type (billing_name, billing_detail) VALUES ('electronic bill', ''); 
INSERT INTO billing_type (billing_name, billing_detail) VALUES ('ticket bill', ''); 

SELECT * FROM billing_type;

create table pay_method(
	id BIGSERIAL PRIMARY KEY,
	pay_name	varchar(150),
	pay_detail	varchar(200)	
);

INSERT INTO pay_method (pay_name, pay_detail) VALUES ('credit card', ''); 
INSERT INTO pay_method (pay_name, pay_detail) VALUES ('debit card', ''); 
INSERT INTO pay_method (pay_name, pay_detail) VALUES ('cash', ''); 

SELECT * FROM pay_method;




