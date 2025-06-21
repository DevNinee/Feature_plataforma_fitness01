import 'package:flutter/material.dart';
import 'package:mighty_fitness/extensions/extension_util/widget_extensions.dart';

import '../components/HtmlWidget.dart';
import '../extensions/widgets.dart';
import '../models/get_setting_response.dart';

class MedicalPolicyScreen extends StatefulWidget {
  const MedicalPolicyScreen({super.key});

  @override
  State<MedicalPolicyScreen> createState() => _MedicalPolicyScreenState();
}

class _MedicalPolicyScreenState extends State<MedicalPolicyScreen> {
  SettingList? settingList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Informações médicas', context: context),
      body: SingleChildScrollView(child: const HtmlWidget(postContent: 'A qualidade da informação é nossa prioridade. Todas as referências usadas neste aplicativo são baseadas em artigos acadêmicos, estudos reconhecidos e materiais revisados por especialistas.<br><br>Buscamos sempre validar e atualizar os conteúdos para garantir precisão e alinhamento com os avanços científicos.<br><br>Confira abaixo as fontes utilizadas:<br><br><a href="https://www.who.int">https://www.who.int</a><br><a href="https://www.nutritionsociety.org">https://www.nutritionsociety.org</a><br><a href="https://www.ncbi.nlm.nih.gov/pmc/">https://www.ncbi.nlm.nih.gov/pmc/</a><br><br><b>Este conteúdo tem caráter informativo e não substitui a orientação de profissionais habilitados. Para suporte individualizado, consulte um especialista.<b>').paddingSymmetric(horizontal: 8).paddingOnly(bottom: 20)),
    );
  }
}
