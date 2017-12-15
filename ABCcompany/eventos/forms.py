# -*- coding: utf-8 -*-
import os, sys
from django import forms
from .models import Perfiles, Evento, Noticia
from captcha.fields import ReCaptchaField

GENDER_CHOICE = (
    ('M', 'Masculino'),
    ('F', 'Femenino'),
)
COUNTRIES = (
    ('US', 'United States'),
    ('AF', 'Afghanistan'),
    ('AL', 'Albania'),
    ('DZ', 'Algeria'),
    ('AS', 'American Samoa'),
    ('AD', 'Andorra'),
    ('AO', 'Angola'),
    ('AI', 'Anguilla'),
    ('AQ', 'Antarctica'),
    ('AG', 'Antigua And Barbuda'),
    ('AR', 'Argentina'),
    ('AM', 'Armenia'),
    ('AW', 'Aruba'),
    ('AU', 'Australia'),
    ('AT', 'Austria'),
    ('AZ', 'Azerbaijan'),
    ('BS', 'Bahamas'),
    ('BH', 'Bahrain'),
    ('BD', 'Bangladesh'),
    ('BB', 'Barbados'),
    ('BY', 'Belarus'),
    ('BE', 'Belgium'),
    ('BZ', 'Belize'),
    ('BJ', 'Benin'),
    ('BM', 'Bermuda'),
    ('BT', 'Bhutan'),
    ('BO', 'Bolivia'),
    ('BA', 'Bosnia And Herzegowina'),
    ('BW', 'Botswana'),
    ('BV', 'Bouvet Island'),
    ('BR', 'Brazil'),
    ('BN', 'Brunei Darussalam'),
    ('BG', 'Bulgaria'),
    ('BF', 'Burkina Faso'),
    ('BI', 'Burundi'),
    ('KH', 'Cambodia'),
    ('CM', 'Cameroon'),
    ('CA', 'Canada'),
    ('CV', 'Cape Verde'),
    ('KY', 'Cayman Islands'),
    ('CF', 'Central African Rep'),
    ('TD', 'Chad'),
    ('CL', 'Chile'),
    ('CN', 'China'),
    ('CX', 'Christmas Island'),
    ('CC', 'Cocos Islands'),
    ('CO', 'Colombia'),
    ('KM', 'Comoros'),
    ('CG', 'Congo'),
    ('CK', 'Cook Islands'),
    ('CR', 'Costa Rica'),
    ('CI', 'Cote D`ivoire'),
    ('HR', 'Croatia'),
    ('CU', 'Cuba'),
    ('CY', 'Cyprus'),
    ('CZ', 'Czech Republic'),
    ('DK', 'Denmark'),
    ('DJ', 'Djibouti'),
    ('DM', 'Dominica'),
    ('DO', 'Dominican Republic'),
    ('TP', 'East Timor'),
    ('EC', 'Ecuador'),
    ('EG', 'Egypt'),
    ('SV', 'El Salvador'),
    ('GQ', 'Equatorial Guinea'),
    ('ER', 'Eritrea'),
    ('EE', 'Estonia'),
    ('ET', 'Ethiopia'),
    ('FK', 'Falkland Islands (Malvinas)'),
    ('FO', 'Faroe Islands'),
    ('FJ', 'Fiji'),
    ('FI', 'Finland'),
    ('FR', 'France'),
    ('GF', 'French Guiana'),
    ('PF', 'French Polynesia'),
    ('TF', 'French S. Territories'),
    ('GA', 'Gabon'),
    ('GM', 'Gambia'),
    ('GE', 'Georgia'),
    ('DE', 'Germany'),
    ('GH', 'Ghana'),
    ('GI', 'Gibraltar'),
    ('GR', 'Greece'),
    ('GL', 'Greenland'),
    ('GD', 'Grenada'),
    ('GP', 'Guadeloupe'),
    ('GU', 'Guam'),
    ('GT', 'Guatemala'),
    ('GN', 'Guinea'),
    ('GW', 'Guinea-bissau'),
    ('GY', 'Guyana'),
    ('HT', 'Haiti'),
    ('HN', 'Honduras'),
    ('HK', 'Hong Kong'),
    ('HU', 'Hungary'),
    ('IS', 'Iceland'),
    ('IN', 'India'),
    ('ID', 'Indonesia'),
    ('IR', 'Iran'),
    ('IQ', 'Iraq'),
    ('IE', 'Ireland'),
    ('IL', 'Israel'),
    ('IT', 'Italy'),
    ('JM', 'Jamaica'),
    ('JP', 'Japan'),
    ('JO', 'Jordan'),
    ('KZ', 'Kazakhstan'),
    ('KE', 'Kenya'),
    ('KI', 'Kiribati'),
    ('KP', 'Korea (North)'),
    ('KR', 'Korea (South)'),
    ('KW', 'Kuwait'),
    ('KG', 'Kyrgyzstan'),
    ('LA', 'Laos'),
    ('LV', 'Latvia'),
    ('LB', 'Lebanon'),
    ('LS', 'Lesotho'),
    ('LR', 'Liberia'),
    ('LY', 'Libya'),
    ('LI', 'Liechtenstein'),
    ('LT', 'Lithuania'),
    ('LU', 'Luxembourg'),
    ('MO', 'Macau'),
    ('MK', 'Macedonia'),
    ('MG', 'Madagascar'),
    ('MW', 'Malawi'),
    ('MY', 'Malaysia'),
    ('MV', 'Maldives'),
    ('ML', 'Mali'),
    ('MT', 'Malta'),
    ('MH', 'Marshall Islands'),
    ('MQ', 'Martinique'),
    ('MR', 'Mauritania'),
    ('MU', 'Mauritius'),
    ('YT', 'Mayotte'),
    ('MX', 'Mexico'),
    ('FM', 'Micronesia'),
    ('MD', 'Moldova'),
    ('MC', 'Monaco'),
    ('MN', 'Mongolia'),
    ('MS', 'Montserrat'),
    ('MA', 'Morocco'),
    ('MZ', 'Mozambique'),
    ('MM', 'Myanmar'),
    ('NA', 'Namibia'),
    ('NR', 'Nauru'),
    ('NP', 'Nepal'),
    ('NL', 'Netherlands'),
    ('AN', 'Netherlands Antilles'),
    ('NC', 'New Caledonia'),
    ('NZ', 'New Zealand'),
    ('NI', 'Nicaragua'),
    ('NE', 'Niger'),
    ('NG', 'Nigeria'),
    ('NU', 'Niue'),
    ('NF', 'Norfolk Island'),
    ('MP', 'Northern Mariana Islands'),
    ('NO', 'Norway'),
    ('OM', 'Oman'),
    ('PK', 'Pakistan'),
    ('PW', 'Palau'),
    ('PA', 'Panama'),
    ('PG', 'Papua New Guinea'),
    ('PY', 'Paraguay'),
    ('PE', 'Peru'),
    ('PH', 'Philippines'),
    ('PN', 'Pitcairn'),
    ('PL', 'Poland'),
    ('PT', 'Portugal'),
    ('PR', 'Puerto Rico'),
    ('QA', 'Qatar'),
    ('RE', 'Reunion'),
    ('RO', 'Romania'),
    ('RU', 'Russian Federation'),
    ('RW', 'Rwanda'),
    ('KN', 'Saint Kitts And Nevis'),
    ('LC', 'Saint Lucia'),
    ('VC', 'St Vincent/Grenadines'),
    ('WS', 'Samoa'),
    ('SM', 'San Marino'),
    ('ST', 'Sao Tome'),
    ('SA', 'Saudi Arabia'),
    ('SN', 'Senegal'),
    ('SC', 'Seychelles'),
    ('SL', 'Sierra Leone'),
    ('SG', 'Singapore'),
    ('SK', 'Slovakia'),
    ('SI', 'Slovenia'),
    ('SB', 'Solomon Islands'),
    ('SO', 'Somalia'),
    ('ZA', 'South Africa'),
    ('ES', 'Spain'),
    ('LK', 'Sri Lanka'),
    ('SH', 'St. Helena'),
    ('PM', 'St.Pierre'),
    ('SD', 'Sudan'),
    ('SR', 'Suriname'),
    ('SZ', 'Swaziland'),
    ('SE', 'Sweden'),
    ('CH', 'Switzerland'),
    ('SY', 'Syrian Arab Republic'),
    ('TW', 'Taiwan'),
    ('TJ', 'Tajikistan'),
    ('TZ', 'Tanzania'),
    ('TH', 'Thailand'),
    ('TG', 'Togo'),
    ('TK', 'Tokelau'),
    ('TO', 'Tonga'),
    ('TT', 'Trinidad And Tobago'),
    ('TN', 'Tunisia'),
    ('TR', 'Turkey'),
    ('TM', 'Turkmenistan'),
    ('TV', 'Tuvalu'),
    ('UG', 'Uganda'),
    ('UA', 'Ukraine'),
    ('AE', 'United Arab Emirates'),
    ('UK', 'United Kingdom'),
    ('UY', 'Uruguay'),
    ('UZ', 'Uzbekistan'),
    ('VU', 'Vanuatu'),
    ('VA', 'Vatican City State'),
    ('VE', 'Venezuela'),
    ('VN', 'Viet Nam'),
    ('VG', 'Virgin Islands (British)'),
    ('VI', 'Virgin Islands (U.S.)'),
    ('EH', 'Western Sahara'),
    ('YE', 'Yemen'),
    ('YU', 'Yugoslavia'),
    ('ZR', 'Zaire'),
    ('ZM', 'Zambia'),
    ('ZW', 'Zimbabwe'),
)


class LoginForm(forms.Form):
    username = forms.CharField()
    password = forms.CharField(widget=forms.PasswordInput())
    robot = ReCaptchaField(error_messages={'required': 'Comprobación de captcha fallida'})

    def clean(self):
        form_data = self.cleaned_data

        if len(form_data['password']) < 8:
            self._errors['password'] = ['La contraseña es menor a 8 caracteres']

        if len(form_data['username']) > 50:
            self._errors['username'] = ['El nombre de usuario supera los 50 caracteres']

        return form_data


class LockForm(forms.Form):
    password = forms.CharField(widget=forms.PasswordInput())

    def clean(self):
        form_data = self.cleaned_data

        if len(form_data['password']) < 8:
            self._errors['password'] = ['La contraseña es menor a 8 caracteres']

        return form_data


class SignupForm(forms.Form):
    username = forms.CharField(label="Nombre de usuario")
    password = forms.CharField(widget=forms.PasswordInput, label="Contraseña")
    rpassword = forms.CharField(widget=forms.PasswordInput)
    nombre = forms.CharField(label="Nombre completo")
    e_mail = forms.EmailField()
    telefono = forms.IntegerField(required=False)
    celular = forms.IntegerField(required=False)
    cedula = forms.IntegerField()
    sexo = forms.ChoiceField(choices=GENDER_CHOICE, initial='M')
    direccion = forms.CharField()
    pais = forms.ChoiceField(choices=COUNTRIES)
    ciudad = forms.CharField()
    robot = ReCaptchaField()

    def clean(self):
        form_data = self.cleaned_data

        if not form_data['password'] == form_data['rpassword']:
            self._errors['rpassword'] = ['Las contraseñas no son iguales']

        if len(form_data['password']) < 8:
            self._errors['password'] = ['La contraseña debe tener un minimo de 8 caracteres']

        if len(form_data['username']) > 50:
            self._errors['username'] = ['El nombre de usuario no puede exceder los 50 caracteres']

        return form_data


class CrearNoticia(forms.Form):
    STATES = ((True, 'Activo'), (False, 'Inactivo'))
    lista = {
        (event.id, event.nombre) for event in Evento.objects.all()
    }
    nombre = forms.CharField(max_length=200)  # help_text='Introduzca aqui el nombre'
    contenido = forms.CharField(widget=forms.Textarea(attrs={'rows': 10, 'cols': 100}))
    estado = forms.ChoiceField(choices=STATES)
    fecha_publicacion = forms.DateField()
    banner = forms.ImageField()
    def __init__(self, *args, **kwargs):
        super(CrearNoticia, self).__init__(*args, **kwargs)
        lista = {
            (event.id, event.nombre) for event in Evento.objects.all()
        }
        self.fields['evento'] = forms.ChoiceField(choices=lista)

    def clean(self):
        form_data = self.cleaned_data

        if len(form_data['nombre']) > 200:
            self._errors['nombre'] = ['el nombre de la noticia no puede ser mayor a 200 caracteres']


class crear_usuario(forms.Form):

    USERS = (
        ('administrador', 'Administrador'),
        ('operador', 'Operador'),
        ('gerente', 'Gerente'),
        ('usuario-registrado', 'Usuario Normal'),
    )

    STATES = (
        ('ACTIVA', 'Activa'),
        ('DESAHABILITADA' , 'Desahabilitada')
    )

    username = forms.CharField(label="Nombre de usuario")
    password = forms.CharField(widget=forms.PasswordInput, label="Contraseña")
    rpassword = forms.CharField(widget=forms.PasswordInput)
    nombre = forms.CharField(label="Nombre completo")
    e_mail = forms.EmailField()
    telefono = forms.IntegerField(required=False)
    celular = forms.IntegerField(required=False)
    cedula = forms.IntegerField()
    sexo = forms.ChoiceField(choices=GENDER_CHOICE, initial='M')
    direccion = forms.CharField()
    pais = forms.ChoiceField(choices=COUNTRIES)
    ciudad = forms.CharField()
    tipo = forms.ChoiceField(choices=USERS, initial='usuario-registrado', widget=forms.RadioSelect)
    estado = forms.ChoiceField(choices=STATES)

    def clean(self):
        form_data = self.cleaned_data

        if not (form_data['password'] == form_data['rpassword']):
            self._errors['rpassword'] = ['Las contraseñas no son iguales']

        if len(form_data['password']) < 8:
            self._errors['password'] = ['La contraseña debe tener un minimo de 8 caracteres']

        if len(form_data['username']) > 50:
            self._errors['username'] = ['El nombre de usuario no puede exceder los 50 caracteres']

        return form_data


class modificar_usuario(forms.Form):

    USERS = (
        ('administrador', 'Administrador'),
        ('operador', 'Operador'),
        ('gerente', 'Gerente'),
        ('usuario-registrado', 'Usuario Normal'),
    )
    STATES = (
        ('ACTIVA', 'Activa'),
        ('DESAHABILITADA', 'Desahabilitada')
    )

    nombre = forms.CharField(label="Nombre completo")
    e_mail = forms.EmailField()
    telefono = forms.IntegerField(required=False)
    celular = forms.IntegerField(required=False)
    cedula = forms.IntegerField()
    sexo = forms.ChoiceField(choices=GENDER_CHOICE, initial='M')
    direccion = forms.CharField()
    pais = forms.ChoiceField(choices=COUNTRIES)
    ciudad = forms.CharField()
    tipo = forms.ChoiceField(choices=USERS, initial='usuario-registrado', widget=forms.RadioSelect)
    user = forms.CharField(widget=forms.HiddenInput())
    estado = forms.ChoiceField(choices=STATES)


class CrearEvento(forms.Form):
    STATES = ((True, 'Activo'), (False, 'Inactivo'))
    nombre = forms.CharField(max_length=200)
    fecha_inicio = forms.DateTimeField(widget=forms.DateInput())
    fecha_fin = forms.DateTimeField(widget=forms.DateInput)
    ubicacion = forms.CharField()
    Imagen_Evento = forms.ImageField()
    descripcion = forms.CharField(widget=forms.Textarea(attrs={'rows': 15, 'cols': 100}), max_length=10000)
    estado = forms.ChoiceField(choices=STATES)


class ModificarEvento(forms.Form):
    STATES = ((True, 'Activo'), (False, 'Inactivo'))
    nombre = forms.CharField(max_length=200)
    fecha_inicio = forms.DateTimeField(widget=forms.DateInput())
    fecha_fin = forms.DateTimeField(widget=forms.DateInput)
    ubicacion = forms.CharField()
    descripcion = forms.CharField(widget=forms.Textarea(attrs={'rows': 15, 'cols': 100}), max_length=10000)
    estado = forms.ChoiceField(choices=STATES)
    evento_select = forms.CharField(widget=forms.HiddenInput())


class ModificarNoticia(forms.Form):
    STATES = ((True, 'Activo'), (False, 'Inactivo'))
    nombre = forms.CharField(max_length=200)  # help_text='Introduzca aqui el nombre'
    contenido = forms.CharField(widget=forms.Textarea(attrs={'rows': 5, 'cols': 100}))
    estado = forms.ChoiceField(choices=STATES)
    fecha_publicacion = forms.DateField()
    imagen = forms.ImageField();
    noticia_select = forms.CharField(widget=forms.HiddenInput())
    def __init__(self, *args, **kwargs):
        super(ModificarNoticia, self).__init__(*args, **kwargs)
        lista = {
            (event.id, event.nombre) for event in Evento.objects.all()
        }
        self.fields['evento'] = forms.ChoiceField(choices=lista)

    def clean(self):
        form_data = self.cleaned_data

        if len(form_data['nombre']) > 200:
            self._errors['nombre'] = ['el nombre de la noticia no puede ser mayor a 200 caracteres']


class SelectUserForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(SelectUserForm, self).__init__(*args, **kwargs)
        lista = {
            (user.usuario.id, user.nombre + " - " + user.cedula.__str__()) for user in Perfiles.objects.all()
        }
        self.fields['seleccion'] = forms.ChoiceField(choices=lista)


class SelectEventForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(SelectEventForm, self).__init__(*args, **kwargs)
        lista = {
            (event.id, event.nombre) for event in Evento.objects.all()
        }
        self.fields['seleccion'] = forms.ChoiceField(choices=lista)


class SelectNoticiaForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(SelectNoticiaForm, self).__init__(*args, **kwargs)
        lista = {
            (noticia.id, noticia.nombre + " - " + noticia.autor.perfiles.nombre) for noticia in Noticia.objects.all()
        }
        self.fields['seleccion'] = forms.ChoiceField(choices=lista)


class InscripcionForm(forms.Form):
    inscrito = forms.IntegerField()
    nombre_inscrito = forms.CharField()
    direccion_inscrito = forms.CharField(required=False)
    telefono = forms.IntegerField()
    celular = forms.IntegerField()
    sexo = forms.ChoiceField(choices=GENDER_CHOICE, initial='M')
    pais = forms.ChoiceField(choices=COUNTRIES)
    email = forms.EmailField()

class consultarPorNumeroPago(forms.Form):
    numero_pago = forms.IntegerField()

class consultarCedulaEvento(forms.Form):

    lista = {
        (event.id, event.nombre) for event in Evento.objects.all()
    }
    cedula = forms.IntegerField()
    evento = forms.ChoiceField(choices=lista)

class seleccionarTipoConsultaInscripcion(forms.Form):
    tipos = (('pago','Numero de Pago'),('cedula', 'Cedula y Evento'))
    categoria = forms.ChoiceField(choices=tipos)

class crearActividad(forms.Form):
    STATES = (
        ('ACTIVA', 'Activa'),
        ('INACTIVA', 'Inactiva')
    )
    nombre = forms.CharField(max_length=200)
    descripcion = forms.CharField(widget=forms.Textarea(attrs={'rows': 10, 'cols': 100}))
    estado = forms.ChoiceField(choices=STATES)
    dia_actividad = forms.IntegerField()
    hora_inicio = forms.TimeField(widget=forms.TimeInput(attrs={'type': 'time'}))
    hora_fin = forms.TimeField(widget=forms.TimeInput(attrs={'type': 'time'}))

    def __init__(self, *args, **kwargs):
        super(crearActividad, self).__init__(*args, **kwargs)
        lista = {
            (event.id, event.nombre) for event in Evento.objects.all()
        }
        self.fields['evento'] = forms.ChoiceField(choices=lista)

class modificarActividad(forms.Form):
    STATES = (
        ('ACTIVA', 'Activa'),
        ('INACTIVA', 'Inactiva')
    )
    nombre = forms.CharField(max_length=200)
    descripcion = forms.CharField(widget=forms.Textarea(attrs={'rows': 10, 'cols': 100}))
    estado = forms.ChoiceField(choices=STATES)
    dia_actividad = forms.IntegerField()
    hora_inicio = forms.TimeField(widget=forms.TimeInput(attrs={'type': 'time'}))
    hora_fin = forms.TimeField(widget=forms.TimeInput(attrs={'type': 'time'}))

    def __init__(self, *args, **kwargs):
        super(modificarActividad, self).__init__(*args, **kwargs)
        lista = {
            (event.id, event.nombre) for event in Evento.objects.all()
        }
        self.fields['evento'] = forms.ChoiceField(choices=lista)
