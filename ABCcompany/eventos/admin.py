# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin
from .models import *

# Register your models here.

admin.site.register(Perfiles)
admin.site.register(Noticia)
admin.site.register(Evento)
admin.site.register(Actividad)
admin.site.register(Inscripcion)
admin.site.register(Inscripcion_operador)
