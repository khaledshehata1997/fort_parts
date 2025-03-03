import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';
import 'package:get/get.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  void initState() {
    final cubit = context.read<SettingsCubit>();
    cubit.fetchTermsAndConditions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title:  Text(
          'termsConditions'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Illustration and Document
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: // Character illustration
                  Image.asset(
                'icons/img_8.png', // Add your character illustration
                width: 150,
                height: 200,
              ),
            ),
            const SizedBox(height: 24),
            // Terms List
            BlocBuilder<SettingsCubit, SettingsStates>(
              buildWhen: (previous, current) => current is FetchTermsAndConditionsState,
              builder: (BuildContext context, state) {
                if (state is FetchTermsAndConditionsState) {
                  return state.stateStatus == StateStatus.success
                      ? Text(
                          state.termsAndConditions,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        )
                      : SizedBox();
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
