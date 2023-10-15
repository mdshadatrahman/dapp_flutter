import 'package:dapp_flutter/app/app.dart';
import 'package:dapp_flutter/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

late W3MService w3mService;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final web3App = await Web3App.createInstance(
    projectId: '3f79b02996e7a2a702d16f75478e02a8',
    metadata: const PairingMetadata(
      name: 'Flutter Dapp Example',
      description: 'Flutter Dapp Example',
      url: 'https://www.walletconnect.com/',
      icons: ['https://walletconnect.com/walletconnect-logo.png'],
      redirect: Redirect(
        native: 'flutterdapp://',
        universal: 'https://www.walletconnect.com',
      ),
    ),
  );
  w3mService = W3MService(web3App: web3App);
  await bootstrap(() => const App());
}
