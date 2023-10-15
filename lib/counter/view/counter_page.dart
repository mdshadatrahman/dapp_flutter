// ignore_for_file: lines_longer_than_80_chars

import 'package:dapp_flutter/counter/counter.dart';
import 'package:dapp_flutter/main_development.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  // final _w3mService = W3MService(
  //   // projectId: '3f79b02996e7a2a702d16f75478e02a8',
  //   projectId: '8f6ff9f1d23275dca958f541efc15168',
  //   metadata: const PairingMetadata(
  //     name: 'Flutter Dapp Example',
  //     description: 'Flutter Dapp Example',
  //     url: 'https://www.walletconnect.com/',
  //     icons: ['https://walletconnect.com/walletconnect-logo.png'],
  //     redirect: Redirect(
  //       // native: 'flutterdapp://',
  //       universal: 'https://www.walletconnect.com',
  //     ),
  //   ),
  //   recommendedWalletIds: {
  //     'afbd95522f4041c71dd4f1a065f971fd32372865b416f95a0b1db759ae33f2a7',
  //     '38f5d18bd8522c244bdd70cb4a68e0e718865155811c043f052fb9f1c51de662',
  //     'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96',
  //   },
  // );

  @override
  void initState() {
    super.initState();
    w3mService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Status(title: 'isInitialized', value: w3mService.isInitialized.toString()),
                Status(title: 'isConnected', value: w3mService.isConnected.toString()),
                Status(title: 'isOpen', value: w3mService.isOpen.toString()),
                Status(title: 'Address', value: w3mService.address.toString()),
                Status(title: 'Avatar URL', value: w3mService.avatarUrl.toString()),
                Status(title: 'Chain Balance', value: w3mService.chainBalance.toString()),
                Status(title: 'Selected Chain', value: w3mService.selectedChain.toString()),
                // Status(title: 'Selected Chain', value: w3mService..toString()),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          W3MConnectWalletButton(
            service: w3mService,
            state: ConnectButtonState.none,
          ),
          // W3MNetworkSelectButton(service: w3mService),
          W3MAccountButton(service: w3mService),
          ElevatedButton(
            onPressed: () async {
              await w3mService.web3App!.request(
                topic: w3mService.session!.topic,
                chainId: 'eip155:11155111',
                request: const SessionRequestParams(
                  method: 'personalSign',
                  params: ['Sign this', '0xdeadbeef'],
                ),
              );
            },
            child: const Text('Test'),
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  const Status({
    required this.title,
    required this.value,
    super.key,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
