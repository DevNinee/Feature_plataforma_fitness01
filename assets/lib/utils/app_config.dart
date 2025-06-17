//region App Name
import 'package:mighty_fitness/utils/app_images.dart';

import '../main.dart';

const APP_NAME = "BioFitLab";
//endregion
var initialSteps = 0;

//region baseurl
/// Note: /Add your domain is www.abc.com
const mBackendURL = "https://biofitlab.online";



//endregion
//region Default Language Code
const DEFAULT_LANGUAGE = 'en';
//endregion

//region Change Walk Through Text
String WALK1_TITLE = languages.lblWalkTitle1;
String WALK2_TITLE = languages.lblWalkTitle2;
String WALK3_TITLE = languages.lblWalkTitle3;
//endregion

//region onesignal
const mOneSignalID = '104c5d78-c0af-4af8-ad90-2092936181fe';
//endregion

//region country

String? countryCode = "+55";
String? countryDail = "55";
//endregion

//region logins
const ENABLE_SOCIAL_LOGIN = true;
const ENABLE_GOOGLE_SIGN_IN = true;
const ENABLE_OTP = true;
const ENABLE_APPLE_SIGN_IN = true;
//endregion

//region perPage value
const EQUIPMENT_PER_PAGE = 10;
const LEVEL_PER_PAGE = 10;
const WORKOUT_TYPE_PAGE = 10;
//endregion

//region payment description and identifier
const mRazorDescription = 'YOUR_PAYMENT_DESCRIPTION';
const mStripeIdentifier = 'YOUR_PAYMENT_IDENTIFIER';
//endregion

//region urls
const mBaseUrl = '$mBackendURL/api/';
//endregion

//region Manage Ads
// const showAdOnDietDetail = false;
// const showAdOnBlogDetail = false;
// const showAdOnExerciseDetail = false;
// const showAdOnProductDetail = false;
// const showAdOnWorkoutDetail = false;
// const showAdOnProgressDetail = false;

// const showBannerAdOnDiet = false;
// const showBannerOnProduct = false;
// const showBannerOnBodyPart = false;
// const showBannerOnEquipment = false;
// const showBannerOnLevel = false;
// const showBannerOnWorkouts = false;
//endregion



const List<String> firstTitles = ['Ganhar músculo', 'Manter a forma', 'Perder peso'];
const List<String> firstDescriptions = [
  'Menor peso com mais repetições e foco em músculos médios e pequenos',
  'Comece com planos básicos de treino muscular e mantenha seus músculos em forma e definidos',
  'Menor peso com mais repetições e pausas mais curtas com exercícios aeróbicos',
];
final List<String> firstIcons = [
  ic_build,
  ic_keep,
  ic_lose,
];


const List<String> secondTitles = ['Totalmente iniciante', 'Iniciante', 'Intermediário', 'Avançado'];
const List<String> secondDescriptions = [
  'Nunca treinei antes',
  'Já treinei antes, mas não levava a sério',
  'Já treinei antes',
  'Treino há anos',
];
final List<String> secondIcons = [
  empty_graph,
  one_graph,
  two_graph,
  full_graph,

];



const List<String> thirdTitles = ['Sem Equipamento', 'Halteres', 'Academia de Garagem', 'Academia Completa', 'Personalizado'];
const List<String> thirdDescriptions = [
  'Treinos em casa com exercícios usando apenas o peso do corpo',
  'Apenas exercícios com halteres e peso do corpo',
  'Exercícios com barra, halteres e peso do corpo',
  'Todos os exercícios com máquinas, barra e tudo mais',
  'Escolha os equipamentos que você tem ou deseja usar',
];
final List<String> thirdIcons = [
  ic_noequpment,
  ic_dumbbell,
  garage_gym,
  full_gym,
  custom,
];



const mOneSignalAppId = 'YOUR_ONESIGNAL_APP_ID';
const mOneSignalRestKey = 'YOUR_ONESIGNAL_REST_KEY';
const mOneSignalChannelId = 'YOUR_ONESIGNAL_CHANNEL_ID';

//firebase keys
const FIREBASE_KEY = "YOUR_FIREBASE_KEY";
const FIREBASE_APP_ID = "YOUR_FIREBASE_APP_ID";
const FIREBASE_MESSAGE_SENDER_ID = "YOUR_FIREBASE_MESSAGE_SENDER_ID";
const FIREBASE_PROJECT_ID = "YOUR_FIREBASE_PROJECT_ID";
const FIREBASE_STORAGE_BUCKET_ID = "YOUR_FIREBASE_STORAGE_BUCKET_ID";

