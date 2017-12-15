# -*- coding: utf-8 -*-
from django.http import HttpResponse
from django.template import loader
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.forms.models import model_to_dict
from eventos.forms import *
from eventos.models import Perfiles, Evento, Noticia, Inscripcion, Actividad, Inscripcion_operador
from django.contrib import messages
from django.db import IntegrityError, transaction


def index(request):
    context = {}  # 'latest_question_list': latest_question_list}
    if request.user.is_anonymous:
        Eventos = Evento.objects.all()[:9]
        Noticias = Noticia.objects.all()[:9]
        context["eventos_lista"] = Eventos
        context['noticias_lista'] = Noticias
        return render(request, 'eventos/users/usuario_publico.html', context)
    else:

        if request.user.perfiles.session == "2":
            return redirect('lock')

        else:
            if request.user.perfiles.tipo == "administrador":
                return render(request, 'eventos/users/administrador.html', context)
            if request.user.perfiles.tipo == "gerente":
                return render(request, 'eventos/users/gerente.html', context)
            if request.user.perfiles.tipo == "operador":
                return render(request, 'eventos/users/operador.html', context)
            else:
                return render(request, 'eventos/users/usuario_registrado.html', context)


def login_page(request):
    context = {}
    form = LoginForm()
    context['form'] = form

    if request.method == "POST":
        form = LoginForm(request.POST)

        if form.is_valid():
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user:
                user.perfiles.session = "1"
                user.perfiles.save()
                login(request, user)
                messages.success(request, "Benvenido \n" + user.perfiles.nombre)
                return redirect('index')
            else:

                messages.error(request, "El usuario o la contraseña son incorrectos ")
                return render(request, 'eventos/users/login.html', context)

        context['form'] = form
        return render(request, 'eventos/users/login.html', context)

    else:
        if request.user.is_anonymous:
            return render(request, 'eventos/users/login.html', context)
        else:

            return redirect('lock')


def logout_page(request):
    if request.user.is_authenticated:
        if request.user.is_anonymous:
            return redirect('login')
        else:
            request.user.perfiles.session = "0"
            request.user.perfiles.save()
            logout(request)
            return redirect('login')
    else:
        return redirect('login')


def register(request):
    if request.user.is_anonymous:
        context = {}
        form = SignupForm()
        context['form'] = form
        if request.method == "POST":
            form_r = SignupForm(request.POST)

            if form_r.is_valid():
                username = request.POST['username']
                password = request.POST['password']
                rpassword = request.POST['rpassword']
                nombre = request.POST['nombre']
                e_mail = request.POST['e_mail']
                telefono = request.POST['telefono']
                celular = request.POST['celular']
                cedula = request.POST['cedula']
                sexo = request.POST['sexo']
                direccion = request.POST['direccion']
                pais = request.POST['pais']
                ciudad = request.POST['ciudad']

                User.objects.create_user(username=username, password=password)
                user = authenticate(None, username=username, password=password)
                perfil = Perfiles()

                perfil.usuario = user;
                perfil.tipo = "usuario_registrado"
                perfil.nombre = nombre
                perfil.telefono = telefono
                perfil.celular = celular
                perfil.email = e_mail
                perfil.session = 0
                perfil.cedula = cedula
                perfil.ciudad = ciudad
                perfil.direccion = direccion
                perfil.sexo = sexo
                perfil.pais = pais

                perfil.save()

                messages.success(request, 'Usuario registrado con exito')
                return redirect('index')

            context['form'] = form_r
            return render(request, 'eventos/users/register.html', context)
        else:
            return render(request, 'eventos/users/register.html', context)
    else:
        return redirect('index')


def lock(request):
    form = LockForm()
    context = {}
    context['form'] = form
    context['usuario'] = request.user.perfiles.nombre
    if request.user.is_anonymous:
        return redirect('index')

    if request.method == "POST":
        if request.user.perfiles.session == "2":
            form = LockForm(request.POST)
            if form.is_valid():
                password = request.POST['password']
                user = authenticate(request, username=request.user, password=password)

                if user:
                    request.user.perfiles.session = "1"
                    request.user.perfiles.save()
                    messages.success(request, "Benvenido de nuevo \n" + request.user.perfiles.nombre)
                    return redirect('index')
                else:
                    context['estadolock'] = "2"
                    messages.error(request, "Contraseña Incorrecta ")
                    return render(request, 'eventos/users/lockscreen.html', context)

            else:
                context['estadolock'] = "2"
                context['form'] = form
                return render(request, 'eventos/users/lockscreen.html', context)

        else:
            request.user.perfiles.session = "2"
            request.user.perfiles.save()
            return redirect('lock')


    else:
        if request.user.perfiles.session == "1":
            context['estadolock'] = "1"
            return render(request, 'eventos/users/lockscreen.html', context)
        else:
            context['estadolock'] = "2"
            return render(request, 'eventos/users/lockscreen.html', context)


def operador_crear_noticia(request):
    context = {};
    form = CrearNoticia()
    context['form_c_n'] = form
    if request.method == "POST":
        form = CrearNoticia(request.POST, request.FILES)
        if form.is_valid():
            nombre = request.POST['nombre']
            contenido = request.POST['contenido']
            estado = request.POST['estado']
            evento = Evento.objects.get(id=request.POST['evento'])
            fecha_publicacion = form.cleaned_data['fecha_publicacion']
            banner = form.cleaned_data['banner']

            usuario = request.user

            noticia = Noticia()
            noticia.nombre = nombre
            noticia.contenido = contenido
            noticia.estado = estado
            noticia.autor = usuario
            noticia.evento = evento
            noticia.fecha_publicacion = fecha_publicacion

            noticia.banner = banner

            noticia.save()

            form = CrearNoticia()
            context['form_c_n'] = form
            messages.success(request, 'Noticia creada con éxito')
            return render(request, "eventos/users/operadorMenu/crear_noticias_operador.html", context)

        else:
            context['form_c_n'] = form
            messages.error(request, 'Error en los datos')
            return render(request, "eventos/users/operadorMenu/crear_noticias_operador.html", context)

    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.tipo == "operador":
                return render(request, "eventos/users/operadorMenu/crear_noticias_operador.html", context)
            return redirect('index')


def admin_crear_usuario(request):
    context = {};
    form = crear_usuario()
    context['form'] = form
    if request.method == "POST":
        form_r = crear_usuario(request.POST)

        if form_r.is_valid():
            username = request.POST['username']
            password = request.POST['password']
            rpassword = request.POST['rpassword']
            nombre = request.POST['nombre']
            e_mail = request.POST['e_mail']
            telefono = request.POST['telefono']
            celular = request.POST['celular']
            cedula = request.POST['cedula']
            sexo = request.POST['sexo']
            direccion = request.POST['direccion']
            pais = request.POST['pais']
            ciudad = request.POST['ciudad']
            tipo = request.POST['tipo']
            estado = request.POST['estado']

            User.objects.create_user(username=username, password=password)
            user = authenticate(None, username=username, password=password)
            perfil = Perfiles()

            perfil.usuario = user
            perfil.tipo = tipo
            perfil.nombre = nombre
            perfil.telefono = telefono
            perfil.celular = celular
            perfil.email = e_mail
            perfil.session = 0
            perfil.cedula = cedula
            perfil.ciudad = ciudad
            perfil.direccion = direccion
            perfil.sexo = sexo
            perfil.pais = pais
            perfil.estado = estado

            perfil.save()

            form = crear_usuario()
            context['form'] = form
            messages.success(request, 'Usuario registrado con exito')
            return render(request, "eventos/users/administradorMenu/crear_usuario_administrador.html", context)

        context['form'] = form_r
        messages.error(request, "Error en el formulario")
        return render(request, "eventos/users/administradorMenu/crear_usuario_administrador.html", context)
    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.tipo == "administrador":
                return render(request, "eventos/users/administradorMenu/crear_usuario_administrador.html", context)
            return redirect('index')


def administrador_consultar_usuarios(request):
    context = {}
    Usuarios = Perfiles.objects.all()
    context['usuarios'] = Usuarios
    if request.user.is_anonymous:
        return redirect('index')
    else:
        if request.user.perfiles.tipo == "administrador":
            return render(request, "eventos/users/administradorMenu/consultar_usuario_administrador.html", context)
        return redirect('index')


def operador_ver_noticias(request):
    context = {}
    Noticias = Noticia.objects.all()
    context['noticias'] = Noticias
    if request.user.is_anonymous:
        return redirect('index')
    else:
        if request.user.perfiles.tipo == "operador":
            return render(request, "eventos/users/operadorMenu/ver_noticias_operador.html", context)
        return redirect('index')


def operador_crear_evento(request):
    context = {}
    Eventos = CrearEvento()
    context['eventos'] = Eventos
    if request.method == "POST":
        form = CrearEvento(request.POST, request.FILES)

        if form.is_valid():

            nombre = form.cleaned_data['nombre']
            fecha_inicio = form.cleaned_data['fecha_inicio']
            fecha_fin = form.cleaned_data['fecha_fin']
            ubicacion = form.cleaned_data['ubicacion']
            Imagen_Evento = form.cleaned_data['Imagen_Evento']
            descripcion = form.cleaned_data['descripcion']
            estado = form.cleaned_data['estado']

            event = Evento()

            event.nombre = nombre
            event.fecha_inicio = fecha_inicio
            event.fecha_fin = fecha_fin
            event.ubicacion = ubicacion
            event.banner = Imagen_Evento
            event.descripcion = descripcion
            event.estado = estado

            event.save()
            Eventos = CrearEvento()
            context['eventos'] = Eventos
            messages.success(request, 'Evento creado con exito')
            return render(request, "eventos/users/operadorMenu/crear_evento_operador.html", context)
        else:
            context['eventos'] = form
            return render(request, "eventos/users/operadorMenu/crear_evento_operador.html", context)
    else:
        if request.user.is_anonymous:
            return redirect('index')
        elif request.user.perfiles.tipo == "operador":
            return render(request, "eventos/users/operadorMenu/crear_evento_operador.html", context)
        return redirect('index')


def admin_modificar_usuario(request):
    context = {}

    if request.method == "POST":
        pregunta = request.POST.get('seleccion', None)
        if pregunta is not None:
            id = request.POST['seleccion']
            usuarioUser = User.objects.get(id=id)
            usuario = Perfiles.objects.get(usuario=usuarioUser)
            data = {
                'nombre': usuario.nombre,
                'e_mail': usuario.email,
                'telefono': usuario.telefono,
                'celular': usuario.celular,
                'cedula': usuario.cedula,
                'sexo': usuario.sexo,
                'direccion': usuario.direccion,
                'pais': usuario.pais,
                'ciudad': usuario.ciudad,
                'tipo': usuario.tipo,
                'estado': usuario.estado,
                'user': id

            }
            form_r = modificar_usuario(initial=data)
            context['form_modify_user'] = form_r
            return render(request, "eventos/users/administradorMenu/modificar_usuario_administrador.html", context)
        else:
            form_r = modificar_usuario(request.POST)
            if form_r.is_valid():
                nombre = request.POST['nombre']
                e_mail = request.POST['e_mail']
                telefono = request.POST['telefono']
                celular = request.POST['celular']
                cedula = request.POST['cedula']
                sexo = request.POST['sexo']
                direccion = request.POST['direccion']
                pais = request.POST['pais']
                ciudad = request.POST['ciudad']
                tipo = request.POST['tipo']
                estado = request.POST['estado']
                identificador_usuario = form_r.cleaned_data['user']
                user = User.objects.get(id=identificador_usuario)
                perfil = user.perfiles

                perfil.usuario = user
                perfil.tipo = tipo
                perfil.nombre = nombre
                perfil.telefono = telefono
                perfil.celular = celular
                perfil.email = e_mail
                perfil.session = 0
                perfil.cedula = cedula
                perfil.ciudad = ciudad
                perfil.direccion = direccion
                perfil.sexo = sexo
                perfil.pais = pais
                perfil.estado = estado

                perfil.save()
                form_r = modificar_usuario()
                context['form_modify_user'] = form_r
                messages.success(request, 'Usuario registrado con exito')
                return redirect('administrador_usuario_selecting_modify')

            context['form_modify_user'] = form_r
            return render(request, "eventos/users/administradorMenu/modificar_usuario_administrador.html", context)

    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.tipo == "administrador":
                return redirect('administrador_usuario_selecting_modify')
            return redirect('index')


def admin_modificar_usuario_seleccion(request):
    context = {}
    formulario = SelectUserForm()
    context['form_select'] = formulario
    if request.method == "POST":
        return render(request, "eventos/users/administradorMenu/seleccion_usuario_modificar_administrador.html",
                      context)
    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.tipo == "administrador":
                return render(request, "eventos/users/administradorMenu/seleccion_usuario_modificar_administrador.html",
                              context)
            return redirect('index')


def operador_modificar_evento_seleccionar(request):
    context = {}
    formulario = SelectEventForm()
    context['form_select'] = formulario
    if request.method == "POST":
        return render(request, "eventos/users/operadorMenu/seleccion_evento_modificar_operador.html",
                      context)
    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.tipo == "operador":
                return render(request, "eventos/users/operadorMenu/seleccion_evento_modificar_operador.html",
                              context)
            return redirect('index')


def operador_modificar_evento(request):
    context = {}

    if request.method == "POST":
        pregunta = request.POST.get('seleccion', None)
        if pregunta is not None:
            id = request.POST['seleccion']
            event = Evento.objects.get(id=id)
            data = {
                'nombre': event.nombre,
                'fecha_inicio': event.fecha_inicio,
                'fecha_fin': event.fecha_fin,
                'ubicacion': event.ubicacion,
                'descripcion': event.descripcion,
                'estado': event.estado,
                'evento_select': id,
            }
            form_r = ModificarEvento(initial=data)
            context['form_modify_event'] = form_r
            return render(request, "eventos/users/operadorMenu/modificar_evento_operador.html", context)
        else:
            form_r = ModificarEvento(request.POST, request.FILES)
            if form_r.is_valid():
                nombre = form_r.cleaned_data['nombre']
                fecha_inicio = form_r.cleaned_data['fecha_inicio']
                fecha_fin = form_r.cleaned_data['fecha_fin']
                ubicacion = form_r.cleaned_data['ubicacion']
                descripcion = form_r.cleaned_data['descripcion']
                estado = form_r.cleaned_data['estado']
                id = form_r.cleaned_data['evento_select']

                eventoModify = Evento.objects.get(id=id)

                eventoModify.nombre = nombre
                eventoModify.fecha_inicio = fecha_inicio
                eventoModify.fecha_fin = fecha_fin
                eventoModify.ubicacion = ubicacion
                eventoModify.descripcion = descripcion
                eventoModify.estado = estado

                eventoModify.save()

                form_r = ModificarEvento()
                context['form_modify_event'] = form_r
                messages.success(request, 'Evento registrado con exito')
                return redirect('operador_eventos_select_modify')

            context['form_modify_event'] = form_r
            return render(request, "eventos/users/operadorMenu/modificar_evento_operador.html", context)

    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.tipo == "operador":
                return redirect('operador_eventos_select_modify')
            return redirect('index')


def operador_ver_eventos(request):
    context = {}
    Eventos = Evento.objects.all()
    context['eventos'] = Eventos
    if request.user.is_anonymous:
        return redirect('index')
    else:
        if request.user.perfiles.tipo == "operador":
            return render(request, "eventos/users/operadorMenu/ver_evento_operador.html", context)
        if request.user.perfiles.tipo == "gerente":
            return render(request, "eventos/users/gerenteMenu/ver_eventos_gerente.html", context)
        return redirect('index')


def operador_modificar_noticia_seleccionar(request):
    context = {}
    formulario = SelectNoticiaForm()
    context['form_select'] = formulario
    if request.method == "POST":
        return render(request, "eventos/users/operadorMenu/seleccion_noticia_modificar_operador.html",
                      context)
    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.tipo == "operador":
                return render(request, "eventos/users/operadorMenu/seleccion_noticia_modificar_operador.html",
                              context)
            return redirect('index')


def operador_modificar_noticia(request):
    context = {}

    if request.method == "POST":
        pregunta = request.POST.get('seleccion', None)
        if pregunta is not None:
            id = request.POST['seleccion']
            noticia = Noticia.objects.get(id=id)
            data = {
                'nombre': noticia.nombre,
                'contenido': noticia.contenido,
                'estado': noticia.estado,
                'evento': noticia.evento.id,
                'fecha_publicacion': noticia.fecha_publicacion,
                'imagen': noticia.banner,
                'noticia_select': id,
            }
            form_r = ModificarNoticia(initial=data)
            context['form_c_n'] = form_r
            return render(request, "eventos/users/operadorMenu/modificar_noticia_operador.html", context)
        else:
            form_r = ModificarNoticia(request.POST, request.FILES)
            if form_r.is_valid():
                nombre = form_r.cleaned_data['nombre']
                contenido = form_r.cleaned_data['contenido']
                estado = form_r.cleaned_data['estado']
                evento = form_r.cleaned_data['evento']
                fecha_publicacion = form_r.cleaned_data['fecha_publicacion']
                id = form_r.cleaned_data['noticia_select']
                imagen = form_r.cleaned_data['imagen']

                noticia = Noticia.objects.get(id=id)

                noticia.nombre = nombre
                noticia.contenido = contenido
                noticia.estado = estado
                noticia.fecha_publicacion = fecha_publicacion
                noticia.banner = imagen

                evento_select = Evento.objects.get(id=evento)

                noticia.evento = evento_select

                noticia.save()

                form_r = ModificarNoticia()
                context['form_c_n'] = form_r
                messages.success(request, 'Noticia registrado con exito')
                return redirect('operador_noticia_select_modify')

            context['form_c_n'] = form_r
            return render(request, "eventos/users/operadorMenu/modificar_noticia_operador.html", context)

    else:
        if request.user.is_anonymous:
            return redirect('index')
        else:
            if request.user.perfiles.session == "2":
                return redirect('lock')

            if request.user.perfiles.tipo == "operador":
                return redirect('operador_noticia_select_modify')
            return redirect('index')


def public_event(request, event_id):
    context = {}

    if request.user.is_anonymous:
        evento_seleccionado = get_object_or_404(Evento, pk=event_id)
        context['evento'] = evento_seleccionado
        return render(request, 'eventos/users/usuario_publico/usuario_publico_evento.html', context)

    else:

        if request.user.perfiles.session == "2":
            return redirect('lock')

        else:
            evento_seleccionado = get_object_or_404(Evento, pk=event_id)
            context['evento'] = evento_seleccionado
            return render(request, 'eventos/users/usuario_publico/usuario_publico_evento.html', context)


def public_new(request, new_id):
    context = {}

    if request.user.is_anonymous:
        noticia_seleccionado = get_object_or_404(Noticia, pk=new_id)
        context['noticia'] = noticia_seleccionado
        return render(request, 'eventos/users/usuario_publico/usuario_publico_noticia.html', context)

    else:

        if request.user.perfiles.session == "2":
            return redirect('lock')

        else:
            noticia_seleccionado = get_object_or_404(Noticia, pk=new_id)
            context['noticia'] = noticia_seleccionado
            return render(request, 'eventos/users/usuario_publico/usuario_publico_noticia.html', context)


def all_events(request):
    context = {}

    if request.user.is_anonymous:
        Eventos = Evento.objects.all()
        context["eventos_lista"] = Eventos
        return render(request, 'eventos/users/usuario_publico/eventos.html', context)

    else:

        if request.user.perfiles.session == "2":
            return redirect('lock')

        else:
            Eventos = Evento.objects.all()
            context["eventos_lista"] = Eventos
            return render(request, 'eventos/users/usuario_publico/eventos.html', context)


def all_news(request):
    context = {}

    if request.user.is_anonymous:
        Noticias = Noticia.objects.all()
        context["noticias_lista"] = Noticias
        return render(request, 'eventos/users/usuario_publico/noticias.html', context)

    else:

        if request.user.perfiles.session == "2":
            return redirect('lock')

        else:
            Noticias = Noticia.objects.all()
            context["noticias_lista"] = Noticias
            return render(request, 'eventos/users/usuario_publico/noticias.html', context)


def ins_event(request, event_id):
    context = {}
    if request.method == "POST":
        inscripcion = InscripcionForm(request.POST)

        if inscripcion.is_valid():
            evento_seleccionado = get_object_or_404(Evento, pk=event_id)

            participante = Inscripcion()

            participante.inscrito = inscripcion.cleaned_data['inscrito']
            participante.nombre_inscrito = inscripcion.cleaned_data['nombre_inscrito']
            participante.direccion_inscrito = inscripcion.cleaned_data['direccion_inscrito']
            participante.telefono = inscripcion.cleaned_data['telefono']
            participante.celular = inscripcion.cleaned_data['celular']
            participante.evento = evento_seleccionado
            participante.correo = inscripcion.cleaned_data['email']
            participante.pais = inscripcion.cleaned_data['pais']
            participante.sexo = inscripcion.cleaned_data['sexo']
            participante.estado = "PREINSCRITO"

            participante.save()

            messages.success(request, "Inscripción Realizada")
            return redirect(
                "http://127.0.0.1:8000/eventos/11ce90de02275791ef32cfdbcbd4c754/8875db2de54c570d54de078e232a7767/" + participante.id.__str__())
        else:
            evento_seleccionado = get_object_or_404(Evento, pk=event_id)
            context['evento'] = evento_seleccionado
            context['formulario'] = inscripcion
            messages.error(request, "Datos del formulario no validos")
            return render(request, 'eventos/users/usuario_publico/inscripcion.html', context)
    else:
        evento_seleccionado = get_object_or_404(Evento, pk=event_id)
        inscripcion = InscripcionForm()
        context['evento'] = evento_seleccionado
        context['formulario'] = inscripcion
        return render(request, 'eventos/users/usuario_publico/inscripcion.html', context)


def datos_pago(request, ins_id):
    context = {}
    participante = get_object_or_404(Inscripcion, pk=ins_id)
    evento_seleccionado = get_object_or_404(Evento, pk=participante.evento.id)
    context['evento'] = evento_seleccionado
    context['inscrito'] = participante
    return render(request, 'eventos/users/usuario_publico/datos_pago.html', context)


def consultar_categoria_inscripcion(request):
    context = {}

    if request.method == "POST":
        form = seleccionarTipoConsultaInscripcion(request.POST)

        if form.is_valid():
            if form.cleaned_data['categoria'] == "pago":
                return redirect('con_cat_ins_pa')
            else:
                return redirect('con_cat_ins_ce')
        else:
            context['form'] = form
            return render(request, 'eventos/users/usuario_publico/consultasIncripciones/seleccionar_categoria.html',
                          context)

    else:
        form = seleccionarTipoConsultaInscripcion()
        context['form'] = form
        return render(request, 'eventos/users/usuario_publico/consultasIncripciones/seleccionar_categoria.html',
                      context)


def consultar_categoria_pago(request):
    context = {}

    if request.method == "POST":
        form = consultarPorNumeroPago(request.POST)

        if form.is_valid():
            numero = form.cleaned_data['numero_pago']

            if Inscripcion.objects.filter(id=numero).exists():
                participante = Inscripcion.objects.get(id=numero)
                context['participante'] = participante
                return redirect(
                    "http://127.0.0.1:8000/eventos/consultar/inscripcion/" + participante.id.__str__() + "/resultado")
            else:
                form = consultarPorNumeroPago()
                context['form'] = form
                messages.error(request, "Este numero de pago no existe")
                return render(request, 'eventos/users/usuario_publico/consultasIncripciones/consulta_pago.html',
                              context)

        else:
            context['form'] = form
            messages.error(request, "")
            return render(request, 'eventos/users/usuario_publico/consultasIncripciones/consulta_pago.html', context)

    else:
        form = consultarPorNumeroPago()
        context['form'] = form
        return render(request,
                      'eventos/users/usuario_publico/consultasIncripciones/consulta_pago.html',
                      context)


def consultar_categoria_cedula(request):
    context = {}

    if request.method == "POST":
        form = consultarCedulaEvento(request.POST)

        if form.is_valid():
            numero = form.cleaned_data['cedula']
            evento = form.cleaned_data['evento']

            if Inscripcion.objects.filter(inscrito=numero, evento=evento).exists():
                participante = Inscripcion.objects.get(inscrito=numero, evento=evento)
                context['participante'] = participante
                return redirect(
                    "http://127.0.0.1:8000/eventos/consultar/inscripcion/" + participante.id.__str__() + "/resultado")
            else:
                form = consultarCedulaEvento()
                context['form'] = form
                messages.error(request, "No existe incripción con estos datos")
                return render(request, 'eventos/users/usuario_publico/consultasIncripciones/conuslta_cedula.html',
                              context)
        else:
            context['form'] = form
            return render(request, 'eventos/users/usuario_publico/consultasIncripciones/conuslta_cedula.html', context)

    else:
        form = consultarCedulaEvento()
        context['form'] = form
        return render(request, 'eventos/users/usuario_publico/consultasIncripciones/conuslta_cedula.html', context)


def resultado_consulta_inscripcion(request, pay_id):
    context = {}
    participante = get_object_or_404(Inscripcion, pk=pay_id)
    context['participante'] = participante
    return render(request, 'eventos/users/usuario_publico/consultasIncripciones/resultado.html', context)


def ver_pre_ins(request):
    context = {}

    if request.user.is_anonymous:
        return redirect('index')
    else:

        if request.user.perfiles.tipo == "operador":

            inscritos = Inscripcion.objects.filter(estado="PREINSCRITO")
            context['inscritos'] = inscritos
            return render(request, 'eventos/users/operadorMenu/ver_preinscritos.html', context)

        else:
            return redirect('index')


def aceptar_ins(request, pay_id):
    context = {}
    try:
        with transaction.atomic():
            inscripcion = Inscripcion.objects.get(id=pay_id)

            if inscripcion.confirmar_pago(request):
                ins = Inscripcion_operador()

                ins.operador = request.user
                ins.inscripcion = inscripcion

                ins.save()
                messages.success(request, "Inscripción aceptada")
                return redirect('ver_pre_ins')
            else:
                messages.error(request, "El pago no se ha registrado")
                return redirect('ver_pre_ins')
    except IntegrityError:
        messages.error(request, "Operacion abortada, fallo inesperado")
        return redirect('index')


def rechazar_ins(request, pay_id):
    context = {}

    inscripcion = Inscripcion.objects.get(id=pay_id)

    if inscripcion.confirmar_pago(request):
        messages.error(request,
                       "Esta inscripción ya fue pagada, no puede rechazarla, se movio a la seccion de inscritos")
        return redirect('ver_pre_ins')
    else:
        inscripcion.delete()
        messages.success(request, "incripción rechazada")
        return redirect('ver_pre_ins')


def ver_ins(request):
    context = {}

    if request.user.is_anonymous:
        return redirect('index')
    else:

        if request.user.perfiles.tipo == "operador":

            inscritos = Inscripcion.objects.filter(estado="INSCRITO")
            context['inscritos'] = inscritos
            return render(request, 'eventos/users/operadorMenu/ver_ins.html', context)

        else:
            return redirect('index')


def cr_act(request):
    context = {}
    if request.user.is_anonymous:
        return redirect('index')
    else:
        if request.user.perfiles.session == 2:
            return redirect('lock')
        elif request.user.perfiles.tipo == "operador":
            if request.method == "POST":
                form = crearActividad(request.POST)

                if form.is_valid():
                    actividad = Actividad()

                    evento = Evento.objects.get(id=form.cleaned_data['evento'])

                    actividad.estado = form.cleaned_data['estado']
                    actividad.nombre = form.cleaned_data['nombre']
                    actividad.descripcion = form.cleaned_data['descripcion']
                    actividad.dia_actividad = form.cleaned_data['dia_actividad']
                    actividad.hora_inicio = form.cleaned_data['hora_inicio']
                    actividad.hora_fin = form.cleaned_data['hora_fin']
                    actividad.evento = evento

                    actividad.save()

                    form = crearActividad()
                    context['form'] = form
                    messages.success(request, 'Actividad creada')
                    return render(request, 'eventos/users/operadorMenu/crear_actividad.html', context)

                else:
                    context['form'] = form
                    messages.error(request, 'Error en el formulario')
                    return render(request, 'eventos/users/operadorMenu/crear_actividad.html', context)
            else:
                form = crearActividad()
                context['form'] = form
                return render(request, 'eventos/users/operadorMenu/crear_actividad.html', context)
        else:
            return redirect('index')


def list_mod_act(request):
    context = {}
    actividades = Actividad.objects.all()
    context['actividades'] = actividades
    return render(request, 'eventos/users/operadorMenu/listar_actividades.html', context)


def edit_act(request, act_id):
    context = {}
    if request.user.is_anonymous:
        return redirect('index')
    else:
        if request.user.perfiles.session == 2:
            return redirect('lock')
        elif request.user.perfiles.tipo == "operador":
            if request.method == "POST":
                form = modificarActividad(request.POST)

                if form.is_valid():
                    actividad = Actividad.objects.get(id=act_id)

                    evento = Evento.objects.get(id=form.cleaned_data['evento'])

                    actividad.estado = form.cleaned_data['estado']
                    actividad.nombre = form.cleaned_data['nombre']
                    actividad.descripcion = form.cleaned_data['descripcion']
                    actividad.dia_actividad = form.cleaned_data['dia_actividad']
                    actividad.hora_inicio = form.cleaned_data['hora_inicio']
                    actividad.hora_fin = form.cleaned_data['hora_fin']
                    actividad.evento = evento

                    actividad.save()

                    form = crearActividad()
                    context['form'] = form
                    messages.success(request, 'Actividad modificada')
                    return redirect('list_mod_act')

                else:
                    context['form'] = form
                    messages.error(request, 'Error en el formulario')
                    return render(request, 'eventos/users/operadorMenu/modificar_actividad.html', context)
            else:
                actividad = Actividad.objects.get(id=act_id)
                form = modificarActividad(model_to_dict(actividad))
                context['form'] = form
                return render(request, 'eventos/users/operadorMenu/modificar_actividad.html', context)
        else:
            return redirect('index')


def gerente_ver_eventos(request):
    context = {}
    Eventos = Evento.objects.all()
    context['eventos'] = Eventos
    if request.user.is_anonymous:
        return redirect('index')
    else:
        if request.user.perfiles.tipo == "gerente":
            return render(request, "eventos/users/gerenteMenu/ver_eventos_gerente.html", context)
        return redirect('index')


def gerente_participantes(request):
    context = {}

    if request.user.is_anonymous:
        return redirect('index')
    else:

        if request.user.perfiles.tipo == "gerente":

            inscritos = Inscripcion.objects.filter()
            context['inscritos'] = inscritos
            return render(request, 'eventos/users/gerenteMenu/ver_participantes.html', context)

        else:
            return redirect('index')


def report_1(request):
    context = {}
    lista = [
        [event.nombre.__str__(), Inscripcion.objects.filter(evento=event).count()] for event in
        Evento.objects.all().order_by('fecha_creacion')[:12]
    ]
    context['lista'] = lista
    return render(request, 'eventos/users/gerenteMenu/reporte1.html', context)


def report_2(request):
    context = {}
    lista = [
        [perfil.nombre.__str__(), Noticia.objects.filter(autor=perfil.usuario).count()] for perfil in
        Perfiles.objects.all().filter(tipo="operador")[:12]
    ]
    context['lista'] = lista
    return render(request, 'eventos/users/gerenteMenu/reporte2.html', context)

def ge_calendar(request):
    context = {}
    lista = [
        [event.nombre.__str__(), event.fecha_inicio.strftime('%Y/%m/%d'), event.fecha_fin.strftime('%Y/%m/%d')] for event in Evento.objects.all()
    ]
    context['lista'] = lista
    return render(request,'eventos/users/gerenteMenu/calendario.html',context)
