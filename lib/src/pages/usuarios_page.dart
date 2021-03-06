import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/services/chat_service.dart';
import 'package:chat_app/src/services/socket_service.dart';
import 'package:chat_app/src/services/usuarios_service.dart';
import 'package:chat_app/src/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);
  static const String routeName = 'usuarios-page';

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final usuariosService = UsuariosService();

  List<Usuario> usuarios = <Usuario>[];

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          usuario.nombre,
          style: const TextStyle(color: Colors.black87),
        ),
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async {
            socketService.disconnect();
            await AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login-page');
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: socketService.serverStatus == ServerStatus.online
                ? Icon(Icons.check_circle, color: Colors.blue[400])
                : Icon(Icons.offline_bolt, color: Colors.red[400]),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: usuarios.length,
      itemBuilder: (_, index) => UsuarioListTile(usuario: usuarios[index]),
      separatorBuilder: (_, index) => const Divider(),
    );
  }

  Future<void> _cargarUsuarios() async {
    usuarios = await usuariosService.getUsuarios();
    setState(() {});

    _refreshController.refreshCompleted();
  }
}

class UsuarioListTile extends StatelessWidget {
  const UsuarioListTile({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat-page');
      },
    );
  }
}
