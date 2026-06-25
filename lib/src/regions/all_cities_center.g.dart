// GENERATED — do not edit by hand.
// Regenerate via: dart run bin/gen_center_registrar.dart <regionsRoot>
//
// centerDisc ("half disk visible") correction tables. Opt-in: an
// app wanting the runtime sunrise-convention toggle registers this
// alongside registerAllCities. Transition minutes are convention-
// independent and reused from the upper-limb tables (not set here).
import '../astronomy.dart' show SunriseConvention;
import 'registry.dart';
import 'abudhabi/corrections_center.dart' as abudhabi;
import 'accra/corrections_center.dart' as accra;
import 'addisababa/corrections_center.dart' as addisababa;
import 'adelaide/corrections_center.dart' as adelaide;
import 'agra/corrections_center.dart' as agra;
import 'ahmedabad/corrections_center.dart' as ahmedabad;
import 'allahabad/corrections_center.dart' as allahabad;
import 'almaty/corrections_center.dart' as almaty;
import 'amman/corrections_center.dart' as amman;
import 'amritsar/corrections_center.dart' as amritsar;
import 'amsterdam/corrections_center.dart' as amsterdam;
import 'ankara/corrections_center.dart' as ankara;
import 'athens/corrections_center.dart' as athens;
import 'atlanta/corrections_center.dart' as atlanta;
import 'auckland/corrections_center.dart' as auckland;
import 'aurangabad/corrections_center.dart' as aurangabad;
import 'austin/corrections_center.dart' as austin;
import 'ayodhya/corrections_center.dart' as ayodhya;
import 'bahrain/corrections_center.dart' as bahrain;
import 'bangalore/corrections_center.dart' as bangalore;
import 'bangkok/corrections_center.dart' as bangkok;
import 'barcelona/corrections_center.dart' as barcelona;
import 'beijing/corrections_center.dart' as beijing;
import 'beirut/corrections_center.dart' as beirut;
import 'berlin/corrections_center.dart' as berlin;
import 'bhopal/corrections_center.dart' as bhopal;
import 'bhubaneswar/corrections_center.dart' as bhubaneswar;
import 'birmingham/corrections_center.dart' as birmingham;
import 'bogot/corrections_center.dart' as bogot;
import 'boston/corrections_center.dart' as boston;
import 'brampton/corrections_center.dart' as brampton;
import 'brisbane/corrections_center.dart' as brisbane;
import 'brussels/corrections_center.dart' as brussels;
import 'bucharest/corrections_center.dart' as bucharest;
import 'budapest/corrections_center.dart' as budapest;
import 'buenosaires/corrections_center.dart' as buenosaires;
import 'cairo/corrections_center.dart' as cairo;
import 'calgary/corrections_center.dart' as calgary;
import 'canberra/corrections_center.dart' as canberra;
import 'capetown/corrections_center.dart' as capetown;
import 'chandigarh/corrections_center.dart' as chandigarh;
import 'charlotte/corrections_center.dart' as charlotte;
import 'chennai/corrections_center.dart' as chennai;
import 'chicago/corrections_center.dart' as chicago;
import 'coimbatore/corrections_center.dart' as coimbatore;
import 'colombo/corrections_center.dart' as colombo;
import 'columbus/corrections_center.dart' as columbus;
import 'copenhagen/corrections_center.dart' as copenhagen;
import 'dallas/corrections_center.dart' as dallas;
import 'daressalaam/corrections_center.dart' as daressalaam;
import 'dehradun/corrections_center.dart' as dehradun;
import 'delhi/corrections_center.dart' as delhi;
import 'denpasar/corrections_center.dart' as denpasar;
import 'denver/corrections_center.dart' as denver;
import 'detroit/corrections_center.dart' as detroit;
import 'dhaka/corrections_center.dart' as dhaka;
import 'doha/corrections_center.dart' as doha;
import 'dubai/corrections_center.dart' as dubai;
import 'dublin/corrections_center.dart' as dublin;
import 'durban/corrections_center.dart' as durban;
import 'dwarka/corrections_center.dart' as dwarka;
import 'edinburgh/corrections_center.dart' as edinburgh;
import 'edmonton/corrections_center.dart' as edmonton;
import 'faridabad/corrections_center.dart' as faridabad;
import 'fremont/corrections_center.dart' as fremont;
import 'georgetown/corrections_center.dart' as georgetown;
import 'ghaziabad/corrections_center.dart' as ghaziabad;
import 'glasgow/corrections_center.dart' as glasgow;
import 'gorakhpur/corrections_center.dart' as gorakhpur;
import 'gothenburg/corrections_center.dart' as gothenburg;
import 'gurgaon/corrections_center.dart' as gurgaon;
import 'guwahati/corrections_center.dart' as guwahati;
import 'gwalior/corrections_center.dart' as gwalior;
import 'halifax/corrections_center.dart' as halifax;
import 'hanoi/corrections_center.dart' as hanoi;
import 'haridwar/corrections_center.dart' as haridwar;
import 'helsinki/corrections_center.dart' as helsinki;
import 'hochiminhcity/corrections_center.dart' as hochiminhcity;
import 'hongkong/corrections_center.dart' as hongkong;
import 'honolulu/corrections_center.dart' as honolulu;
import 'houston/corrections_center.dart' as houston;
import 'hubli/corrections_center.dart' as hubli;
import 'hyderabad/corrections_center.dart' as hyderabad;
import 'indianapolis/corrections_center.dart' as indianapolis;
import 'indore/corrections_center.dart' as indore;
import 'islamabad/corrections_center.dart' as islamabad;
import 'istanbul/corrections_center.dart' as istanbul;
import 'jabalpur/corrections_center.dart' as jabalpur;
import 'jaipur/corrections_center.dart' as jaipur;
import 'jakarta/corrections_center.dart' as jakarta;
import 'jalandhar/corrections_center.dart' as jalandhar;
import 'jammu/corrections_center.dart' as jammu;
import 'jeddah/corrections_center.dart' as jeddah;
import 'jodhpur/corrections_center.dart' as jodhpur;
import 'johannesburg/corrections_center.dart' as johannesburg;
import 'kampala/corrections_center.dart' as kampala;
import 'kanpur/corrections_center.dart' as kanpur;
import 'kansascity/corrections_center.dart' as kansascity;
import 'karachi/corrections_center.dart' as karachi;
import 'kathmandu/corrections_center.dart' as kathmandu;
import 'kingston/corrections_center.dart' as kingston;
import 'kirkland/corrections_center.dart' as kirkland;
import 'kochi/corrections_center.dart' as kochi;
import 'kolkata/corrections_center.dart' as kolkata;
import 'kota/corrections_center.dart' as kota;
import 'krakow/corrections_center.dart' as krakow;
import 'kualalumpur/corrections_center.dart' as kualalumpur;
import 'kuwaitcity/corrections_center.dart' as kuwaitcity;
import 'kyiv/corrections_center.dart' as kyiv;
import 'lagos/corrections_center.dart' as lagos;
import 'lahore/corrections_center.dart' as lahore;
import 'lasvegas/corrections_center.dart' as lasvegas;
import 'leicester/corrections_center.dart' as leicester;
import 'lima/corrections_center.dart' as lima;
import 'lisbon/corrections_center.dart' as lisbon;
import 'london/corrections_center.dart' as london;
import 'losangeles/corrections_center.dart' as losangeles;
import 'lucknow/corrections_center.dart' as lucknow;
import 'ludhiana/corrections_center.dart' as ludhiana;
import 'lyon/corrections_center.dart' as lyon;
import 'madrid/corrections_center.dart' as madrid;
import 'madurai/corrections_center.dart' as madurai;
import 'manchester/corrections_center.dart' as manchester;
import 'mangalore/corrections_center.dart' as mangalore;
import 'manila/corrections_center.dart' as manila;
import 'mathura/corrections_center.dart' as mathura;
import 'medellin/corrections_center.dart' as medellin;
import 'meerut/corrections_center.dart' as meerut;
import 'melbourne/corrections_center.dart' as melbourne;
import 'mexicocity/corrections_center.dart' as mexicocity;
import 'miami/corrections_center.dart' as miami;
import 'milan/corrections_center.dart' as milan;
import 'minneapolis/corrections_center.dart' as minneapolis;
import 'mississauga/corrections_center.dart' as mississauga;
import 'mombasa/corrections_center.dart' as mombasa;
import 'montreal/corrections_center.dart' as montreal;
import 'moscow/corrections_center.dart' as moscow;
import 'mumbai/corrections_center.dart' as mumbai;
import 'munich/corrections_center.dart' as munich;
import 'muscat/corrections_center.dart' as muscat;
import 'mussoorie/corrections_center.dart' as mussoorie;
import 'mysore/corrections_center.dart' as mysore;
import 'nagpur/corrections_center.dart' as nagpur;
import 'nairobi/corrections_center.dart' as nairobi;
import 'naples/corrections_center.dart' as naples;
import 'nashik/corrections_center.dart' as nashik;
import 'nashville/corrections_center.dart' as nashville;
import 'newyork/corrections_center.dart' as newyork;
import 'noida/corrections_center.dart' as noida;
import 'orlando/corrections_center.dart' as orlando;
import 'osaka/corrections_center.dart' as osaka;
import 'oslo/corrections_center.dart' as oslo;
import 'ottawa/corrections_center.dart' as ottawa;
import 'panamacity/corrections_center.dart' as panamacity;
import 'paramaribo/corrections_center.dart' as paramaribo;
import 'paris/corrections_center.dart' as paris;
import 'patna/corrections_center.dart' as patna;
import 'perth/corrections_center.dart' as perth;
import 'philadelphia/corrections_center.dart' as philadelphia;
import 'phnompenh/corrections_center.dart' as phnompenh;
import 'phoenix/corrections_center.dart' as phoenix;
import 'pittsburgh/corrections_center.dart' as pittsburgh;
import 'portland/corrections_center.dart' as portland;
import 'portlouis/corrections_center.dart' as portlouis;
import 'porto/corrections_center.dart' as porto;
import 'portofspain/corrections_center.dart' as portofspain;
import 'prague/corrections_center.dart' as prague;
import 'prayagraj/corrections_center.dart' as prayagraj;
import 'pune/corrections_center.dart' as pune;
import 'quito/corrections_center.dart' as quito;
import 'raipur/corrections_center.dart' as raipur;
import 'rajkot/corrections_center.dart' as rajkot;
import 'raleigh/corrections_center.dart' as raleigh;
import 'ranchi/corrections_center.dart' as ranchi;
import 'redmond/corrections_center.dart' as redmond;
import 'regina/corrections_center.dart' as regina;
import 'riodejaneiro/corrections_center.dart' as riodejaneiro;
import 'rishikesh/corrections_center.dart' as rishikesh;
import 'riyadh/corrections_center.dart' as riyadh;
import 'rome/corrections_center.dart' as rome;
import 'rotterdam/corrections_center.dart' as rotterdam;
import 'sacramento/corrections_center.dart' as sacramento;
import 'salem/corrections_center.dart' as salem;
import 'saltlakecity/corrections_center.dart' as saltlakecity;
import 'sandiego/corrections_center.dart' as sandiego;
import 'sanfrancisco/corrections_center.dart' as sanfrancisco;
import 'sanjose/corrections_center.dart' as sanjose;
import 'santiago/corrections_center.dart' as santiago;
import 'seattle/corrections_center.dart' as seattle;
import 'seoul/corrections_center.dart' as seoul;
import 'shanghai/corrections_center.dart' as shanghai;
import 'shirdi/corrections_center.dart' as shirdi;
import 'singapore/corrections_center.dart' as singapore;
import 'sofia/corrections_center.dart' as sofia;
import 'sopaulo/corrections_center.dart' as sopaulo;
import 'srinagar/corrections_center.dart' as srinagar;
import 'stlouis/corrections_center.dart' as stlouis;
import 'stockholm/corrections_center.dart' as stockholm;
import 'surat/corrections_center.dart' as surat;
import 'surrey/corrections_center.dart' as surrey;
import 'suva/corrections_center.dart' as suva;
import 'sydney/corrections_center.dart' as sydney;
import 'taipei/corrections_center.dart' as taipei;
import 'tampa/corrections_center.dart' as tampa;
import 'tashkent/corrections_center.dart' as tashkent;
import 'telaviv/corrections_center.dart' as telaviv;
import 'thane/corrections_center.dart' as thane;
import 'thessaloniki/corrections_center.dart' as thessaloniki;
import 'thiruvananthapuram/corrections_center.dart' as thiruvananthapuram;
import 'tiruchirappalli/corrections_center.dart' as tiruchirappalli;
import 'tirupati/corrections_center.dart' as tirupati;
import 'tokyo/corrections_center.dart' as tokyo;
import 'toronto/corrections_center.dart' as toronto;
import 'udaipur/corrections_center.dart' as udaipur;
import 'ujjain/corrections_center.dart' as ujjain;
import 'vadodara/corrections_center.dart' as vadodara;
import 'vancouver/corrections_center.dart' as vancouver;
import 'varanasi/corrections_center.dart' as varanasi;
import 'vienna/corrections_center.dart' as vienna;
import 'vijayawada/corrections_center.dart' as vijayawada;
import 'visakhapatnam/corrections_center.dart' as visakhapatnam;
import 'vrindavan/corrections_center.dart' as vrindavan;
import 'warangal/corrections_center.dart' as warangal;
import 'warsaw/corrections_center.dart' as warsaw;
import 'washingtondc/corrections_center.dart' as washingtondc;
import 'wellington/corrections_center.dart' as wellington;
import 'winnipeg/corrections_center.dart' as winnipeg;
import 'yangon/corrections_center.dart' as yangon;
import 'zagreb/corrections_center.dart' as zagreb;
import 'zurich/corrections_center.dart' as zurich;

/// Register centerDisc tables for all 230 cities.
bool _registered = false;
void registerAllCitiesCenterDisc() {
  if (_registered) return; // idempotent
  _registered = true;
  registerCity('Abu Dhabi',
      tithi: abudhabi.abudhabiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Accra',
      tithi: accra.accraTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Addis Ababa',
      tithi: addisababa.addisababaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Adelaide',
      tithi: adelaide.adelaideTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Agra',
      tithi: agra.agraTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ahmedabad',
      tithi: ahmedabad.ahmedabadTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Allahabad',
      tithi: allahabad.allahabadTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Almaty',
      tithi: almaty.almatyTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Amman',
      tithi: amman.ammanTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Amritsar',
      tithi: amritsar.amritsarTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Amsterdam',
      tithi: amsterdam.amsterdamTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ankara',
      tithi: ankara.ankaraTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Athens',
      tithi: athens.athensTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Atlanta',
      tithi: atlanta.atlantaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Auckland',
      tithi: auckland.aucklandTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Aurangabad',
      tithi: aurangabad.aurangabadTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Austin',
      tithi: austin.austinTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ayodhya',
      tithi: ayodhya.ayodhyaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bahrain',
      tithi: bahrain.bahrainTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bangalore',
      tithi: bangalore.bangaloreTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bangkok',
      tithi: bangkok.bangkokTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Barcelona',
      tithi: barcelona.barcelonaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Beijing',
      tithi: beijing.beijingTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Beirut',
      tithi: beirut.beirutTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Berlin',
      tithi: berlin.berlinTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bhopal',
      tithi: bhopal.bhopalTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bhubaneswar',
      tithi: bhubaneswar.bhubaneswarTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Birmingham',
      tithi: birmingham.birminghamTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bogotá',
      tithi: bogot.bogotTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Boston',
      tithi: boston.bostonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Brampton',
      tithi: brampton.bramptonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Brisbane',
      tithi: brisbane.brisbaneTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Brussels',
      tithi: brussels.brusselsTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bucharest',
      tithi: bucharest.bucharestTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Budapest',
      tithi: budapest.budapestTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Buenos Aires',
      tithi: buenosaires.buenosairesTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Cairo',
      tithi: cairo.cairoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Calgary',
      tithi: calgary.calgaryTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Canberra',
      tithi: canberra.canberraTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Cape Town',
      tithi: capetown.capetownTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Chandigarh',
      tithi: chandigarh.chandigarhTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Charlotte',
      tithi: charlotte.charlotteTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Chennai',
      tithi: chennai.chennaiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Chicago',
      tithi: chicago.chicagoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Coimbatore',
      tithi: coimbatore.coimbatoreTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Colombo',
      tithi: colombo.colomboTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Columbus',
      tithi: columbus.columbusTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Copenhagen',
      tithi: copenhagen.copenhagenTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dallas',
      tithi: dallas.dallasTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dar es Salaam',
      tithi: daressalaam.daressalaamTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dehradun',
      tithi: dehradun.dehradunTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Delhi',
      tithi: delhi.delhiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Denpasar',
      tithi: denpasar.denpasarTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Denver',
      tithi: denver.denverTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Detroit',
      tithi: detroit.detroitTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dhaka',
      tithi: dhaka.dhakaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Doha',
      tithi: doha.dohaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dubai',
      tithi: dubai.dubaiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dublin',
      tithi: dublin.dublinTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Durban',
      tithi: durban.durbanTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dwarka',
      tithi: dwarka.dwarkaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Edinburgh',
      tithi: edinburgh.edinburghTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Edmonton',
      tithi: edmonton.edmontonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Faridabad',
      tithi: faridabad.faridabadTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Fremont',
      tithi: fremont.fremontTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Georgetown',
      tithi: georgetown.georgetownTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ghaziabad',
      tithi: ghaziabad.ghaziabadTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Glasgow',
      tithi: glasgow.glasgowTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gorakhpur',
      tithi: gorakhpur.gorakhpurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gothenburg',
      tithi: gothenburg.gothenburgTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gurgaon',
      tithi: gurgaon.gurgaonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Guwahati',
      tithi: guwahati.guwahatiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gwalior',
      tithi: gwalior.gwaliorTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Halifax',
      tithi: halifax.halifaxTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hanoi',
      tithi: hanoi.hanoiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Haridwar',
      tithi: haridwar.haridwarTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Helsinki',
      tithi: helsinki.helsinkiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ho Chi Minh City',
      tithi: hochiminhcity.hochiminhcityTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hong Kong',
      tithi: hongkong.hongkongTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Honolulu',
      tithi: honolulu.honoluluTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Houston',
      tithi: houston.houstonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hubli',
      tithi: hubli.hubliTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hyderabad',
      tithi: hyderabad.hyderabadTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Indianapolis',
      tithi: indianapolis.indianapolisTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Indore',
      tithi: indore.indoreTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Islamabad',
      tithi: islamabad.islamabadTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Istanbul',
      tithi: istanbul.istanbulTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jabalpur',
      tithi: jabalpur.jabalpurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jaipur',
      tithi: jaipur.jaipurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jakarta',
      tithi: jakarta.jakartaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jalandhar',
      tithi: jalandhar.jalandharTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jammu',
      tithi: jammu.jammuTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jeddah',
      tithi: jeddah.jeddahTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jodhpur',
      tithi: jodhpur.jodhpurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Johannesburg',
      tithi: johannesburg.johannesburgTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kampala',
      tithi: kampala.kampalaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kanpur',
      tithi: kanpur.kanpurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kansas City',
      tithi: kansascity.kansascityTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Karachi',
      tithi: karachi.karachiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kathmandu',
      tithi: kathmandu.kathmanduTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kingston',
      tithi: kingston.kingstonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kirkland',
      tithi: kirkland.kirklandTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kochi',
      tithi: kochi.kochiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kolkata',
      tithi: kolkata.kolkataTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kota',
      tithi: kota.kotaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Krakow',
      tithi: krakow.krakowTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kuala Lumpur',
      tithi: kualalumpur.kualalumpurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kuwait City',
      tithi: kuwaitcity.kuwaitcityTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kyiv',
      tithi: kyiv.kyivTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lagos',
      tithi: lagos.lagosTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lahore',
      tithi: lahore.lahoreTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Las Vegas',
      tithi: lasvegas.lasvegasTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Leicester',
      tithi: leicester.leicesterTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lima',
      tithi: lima.limaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lisbon',
      tithi: lisbon.lisbonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('London',
      tithi: london.londonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Los Angeles',
      tithi: losangeles.losangelesTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lucknow',
      tithi: lucknow.lucknowTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ludhiana',
      tithi: ludhiana.ludhianaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lyon',
      tithi: lyon.lyonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Madrid',
      tithi: madrid.madridTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Madurai',
      tithi: madurai.maduraiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Manchester',
      tithi: manchester.manchesterTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mangalore',
      tithi: mangalore.mangaloreTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Manila',
      tithi: manila.manilaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mathura',
      tithi: mathura.mathuraTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Medellín',
      tithi: medellin.medellinTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Meerut',
      tithi: meerut.meerutTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Melbourne',
      tithi: melbourne.melbourneTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mexico City',
      tithi: mexicocity.mexicocityTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Miami',
      tithi: miami.miamiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Milan',
      tithi: milan.milanTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Minneapolis',
      tithi: minneapolis.minneapolisTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mississauga',
      tithi: mississauga.mississaugaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mombasa',
      tithi: mombasa.mombasaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Montreal',
      tithi: montreal.montrealTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Moscow',
      tithi: moscow.moscowTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mumbai',
      tithi: mumbai.mumbaiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Munich',
      tithi: munich.munichTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Muscat',
      tithi: muscat.muscatTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mussoorie',
      tithi: mussoorie.mussoorieTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mysore',
      tithi: mysore.mysoreTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nagpur',
      tithi: nagpur.nagpurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nairobi',
      tithi: nairobi.nairobiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Naples',
      tithi: naples.naplesTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nashik',
      tithi: nashik.nashikTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nashville',
      tithi: nashville.nashvilleTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('New York',
      tithi: newyork.newyorkTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Noida',
      tithi: noida.noidaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Orlando',
      tithi: orlando.orlandoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Osaka',
      tithi: osaka.osakaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Oslo',
      tithi: oslo.osloTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ottawa',
      tithi: ottawa.ottawaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Panama City',
      tithi: panamacity.panamacityTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Paramaribo',
      tithi: paramaribo.paramariboTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Paris',
      tithi: paris.parisTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Patna',
      tithi: patna.patnaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Perth',
      tithi: perth.perthTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Philadelphia',
      tithi: philadelphia.philadelphiaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Phnom Penh',
      tithi: phnompenh.phnompenhTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Phoenix',
      tithi: phoenix.phoenixTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Pittsburgh',
      tithi: pittsburgh.pittsburghTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Portland',
      tithi: portland.portlandTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Port Louis',
      tithi: portlouis.portlouisTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Porto',
      tithi: porto.portoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Port of Spain',
      tithi: portofspain.portofspainTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Prague',
      tithi: prague.pragueTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Prayagraj',
      tithi: prayagraj.prayagrajTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Pune',
      tithi: pune.puneTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Quito',
      tithi: quito.quitoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Raipur',
      tithi: raipur.raipurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rajkot',
      tithi: rajkot.rajkotTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Raleigh',
      tithi: raleigh.raleighTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ranchi',
      tithi: ranchi.ranchiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Redmond',
      tithi: redmond.redmondTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Regina',
      tithi: regina.reginaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rio de Janeiro',
      tithi: riodejaneiro.riodejaneiroTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rishikesh',
      tithi: rishikesh.rishikeshTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Riyadh',
      tithi: riyadh.riyadhTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rome',
      tithi: rome.romeTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rotterdam',
      tithi: rotterdam.rotterdamTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Sacramento',
      tithi: sacramento.sacramentoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Salem',
      tithi: salem.salemTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Salt Lake City',
      tithi: saltlakecity.saltlakecityTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('San Diego',
      tithi: sandiego.sandiegoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('San Francisco',
      tithi: sanfrancisco.sanfranciscoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('San Jose',
      tithi: sanjose.sanjoseTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Santiago',
      tithi: santiago.santiagoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Seattle',
      tithi: seattle.seattleTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Seoul',
      tithi: seoul.seoulTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Shanghai',
      tithi: shanghai.shanghaiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Shirdi',
      tithi: shirdi.shirdiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Singapore',
      tithi: singapore.singaporeTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Sofia',
      tithi: sofia.sofiaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('São Paulo',
      tithi: sopaulo.sopauloTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Srinagar',
      tithi: srinagar.srinagarTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('St. Louis',
      tithi: stlouis.stlouisTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Stockholm',
      tithi: stockholm.stockholmTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Surat',
      tithi: surat.suratTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Surrey',
      tithi: surrey.surreyTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Suva',
      tithi: suva.suvaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Sydney',
      tithi: sydney.sydneyTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Taipei',
      tithi: taipei.taipeiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tampa',
      tithi: tampa.tampaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tashkent',
      tithi: tashkent.tashkentTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tel Aviv',
      tithi: telaviv.telavivTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Thane',
      tithi: thane.thaneTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Thessaloniki',
      tithi: thessaloniki.thessalonikiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Thiruvananthapuram',
      tithi: thiruvananthapuram.thiruvananthapuramTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tiruchirappalli',
      tithi: tiruchirappalli.tiruchirappalliTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tirupati',
      tithi: tirupati.tirupatiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tokyo',
      tithi: tokyo.tokyoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Toronto',
      tithi: toronto.torontoTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Udaipur',
      tithi: udaipur.udaipurTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ujjain',
      tithi: ujjain.ujjainTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vadodara',
      tithi: vadodara.vadodaraTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vancouver',
      tithi: vancouver.vancouverTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Varanasi',
      tithi: varanasi.varanasiTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vienna',
      tithi: vienna.viennaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vijayawada',
      tithi: vijayawada.vijayawadaTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Visakhapatnam',
      tithi: visakhapatnam.visakhapatnamTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vrindavan',
      tithi: vrindavan.vrindavanTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Warangal',
      tithi: warangal.warangalTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Warsaw',
      tithi: warsaw.warsawTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Washington DC',
      tithi: washingtondc.washingtondcTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Wellington',
      tithi: wellington.wellingtonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Winnipeg',
      tithi: winnipeg.winnipegTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Yangon',
      tithi: yangon.yangonTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Zagreb',
      tithi: zagreb.zagrebTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Zurich',
      tithi: zurich.zurichTithiCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
}
