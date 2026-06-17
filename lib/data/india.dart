// GENERATED region pack — do not edit by hand.
//
/// India city correction data. Importing this file links ONLY India's
/// cities; cities outside this pack fall back to the Meeus approximation
/// unless another pack registers them.
library;

import 'package:tithi_engine/src/regions/registry.dart';
import 'package:tithi_engine/src/regions/delhi/corrections.dart' as delhi;
import 'package:tithi_engine/src/regions/delhi/boundary_corrections.dart'
    as delhi_b;
import 'package:tithi_engine/src/regions/mumbai/corrections.dart' as mumbai;
import 'package:tithi_engine/src/regions/mumbai/boundary_corrections.dart'
    as mumbai_b;
import 'package:tithi_engine/src/regions/kolkata/corrections.dart' as kolkata;
import 'package:tithi_engine/src/regions/kolkata/boundary_corrections.dart'
    as kolkata_b;
import 'package:tithi_engine/src/regions/chennai/corrections.dart' as chennai;
import 'package:tithi_engine/src/regions/chennai/boundary_corrections.dart'
    as chennai_b;
import 'package:tithi_engine/src/regions/srinagar/corrections.dart' as srinagar;
import 'package:tithi_engine/src/regions/srinagar/boundary_corrections.dart'
    as srinagar_b;
import 'package:tithi_engine/src/regions/bangalore/corrections.dart'
    as bangalore;
import 'package:tithi_engine/src/regions/bangalore/boundary_corrections.dart'
    as bangalore_b;
import 'package:tithi_engine/src/regions/hyderabad/corrections.dart'
    as hyderabad;
import 'package:tithi_engine/src/regions/hyderabad/boundary_corrections.dart'
    as hyderabad_b;
import 'package:tithi_engine/src/regions/pune/corrections.dart' as pune;
import 'package:tithi_engine/src/regions/pune/boundary_corrections.dart'
    as pune_b;
import 'package:tithi_engine/src/regions/ahmedabad/corrections.dart'
    as ahmedabad;
import 'package:tithi_engine/src/regions/ahmedabad/boundary_corrections.dart'
    as ahmedabad_b;
import 'package:tithi_engine/src/regions/jaipur/corrections.dart' as jaipur;
import 'package:tithi_engine/src/regions/jaipur/boundary_corrections.dart'
    as jaipur_b;
import 'package:tithi_engine/src/regions/lucknow/corrections.dart' as lucknow;
import 'package:tithi_engine/src/regions/lucknow/boundary_corrections.dart'
    as lucknow_b;
import 'package:tithi_engine/src/regions/chandigarh/corrections.dart'
    as chandigarh;
import 'package:tithi_engine/src/regions/chandigarh/boundary_corrections.dart'
    as chandigarh_b;
import 'package:tithi_engine/src/regions/jammu/corrections.dart' as jammu;
import 'package:tithi_engine/src/regions/jammu/boundary_corrections.dart'
    as jammu_b;
import 'package:tithi_engine/src/regions/indore/corrections.dart' as indore;
import 'package:tithi_engine/src/regions/indore/boundary_corrections.dart'
    as indore_b;
import 'package:tithi_engine/src/regions/ujjain/corrections.dart' as ujjain;
import 'package:tithi_engine/src/regions/ujjain/boundary_corrections.dart'
    as ujjain_b;
import 'package:tithi_engine/src/regions/bhopal/corrections.dart' as bhopal;
import 'package:tithi_engine/src/regions/bhopal/boundary_corrections.dart'
    as bhopal_b;
import 'package:tithi_engine/src/regions/nagpur/corrections.dart' as nagpur;
import 'package:tithi_engine/src/regions/nagpur/boundary_corrections.dart'
    as nagpur_b;
import 'package:tithi_engine/src/regions/patna/corrections.dart' as patna;
import 'package:tithi_engine/src/regions/patna/boundary_corrections.dart'
    as patna_b;
import 'package:tithi_engine/src/regions/kochi/corrections.dart' as kochi;
import 'package:tithi_engine/src/regions/kochi/boundary_corrections.dart'
    as kochi_b;
import 'package:tithi_engine/src/regions/guwahati/corrections.dart' as guwahati;
import 'package:tithi_engine/src/regions/guwahati/boundary_corrections.dart'
    as guwahati_b;
import 'package:tithi_engine/src/regions/varanasi/corrections.dart' as varanasi;
import 'package:tithi_engine/src/regions/varanasi/boundary_corrections.dart'
    as varanasi_b;
import 'package:tithi_engine/src/regions/amritsar/corrections.dart' as amritsar;
import 'package:tithi_engine/src/regions/amritsar/boundary_corrections.dart'
    as amritsar_b;
import 'package:tithi_engine/src/regions/dehradun/corrections.dart' as dehradun;
import 'package:tithi_engine/src/regions/dehradun/boundary_corrections.dart'
    as dehradun_b;
import 'package:tithi_engine/src/regions/thiruvananthapuram/corrections.dart'
    as thiruvananthapuram;
import 'package:tithi_engine/src/regions/thiruvananthapuram/boundary_corrections.dart'
    as thiruvananthapuram_b;
import 'package:tithi_engine/src/regions/coimbatore/corrections.dart'
    as coimbatore;
import 'package:tithi_engine/src/regions/coimbatore/boundary_corrections.dart'
    as coimbatore_b;
import 'package:tithi_engine/src/regions/visakhapatnam/corrections.dart'
    as visakhapatnam;
import 'package:tithi_engine/src/regions/visakhapatnam/boundary_corrections.dart'
    as visakhapatnam_b;
import 'package:tithi_engine/src/regions/mangalore/corrections.dart'
    as mangalore;
import 'package:tithi_engine/src/regions/mangalore/boundary_corrections.dart'
    as mangalore_b;
import 'package:tithi_engine/src/regions/mysore/corrections.dart' as mysore;
import 'package:tithi_engine/src/regions/mysore/boundary_corrections.dart'
    as mysore_b;
import 'package:tithi_engine/src/regions/noida/corrections.dart' as noida;
import 'package:tithi_engine/src/regions/noida/boundary_corrections.dart'
    as noida_b;
import 'package:tithi_engine/src/regions/gurgaon/corrections.dart' as gurgaon;
import 'package:tithi_engine/src/regions/gurgaon/boundary_corrections.dart'
    as gurgaon_b;

/// Register India's 30 cities.
bool _registered = false;
void registerIndia() {
  if (_registered) return; // idempotent: register once
  _registered = true;
  registerCity('Delhi',
      tithi: delhi.delhiTithiCorrections,
      transitions: delhi.delhiTransitionMinutesMap,
      amavasya: delhi_b.delhiAmavasyaCorrections,
      purnima: delhi_b.delhiPurnimaCorrections);
  registerCity('Mumbai',
      tithi: mumbai.mumbaiTithiCorrections,
      transitions: mumbai.mumbaiTransitionMinutesMap,
      amavasya: mumbai_b.mumbaiAmavasyaCorrections,
      purnima: mumbai_b.mumbaiPurnimaCorrections);
  registerCity('Kolkata',
      tithi: kolkata.kolkataTithiCorrections,
      transitions: kolkata.kolkataTransitionMinutesMap,
      amavasya: kolkata_b.kolkataAmavasyaCorrections,
      purnima: kolkata_b.kolkataPurnimaCorrections);
  registerCity('Chennai',
      tithi: chennai.chennaiTithiCorrections,
      transitions: chennai.chennaiTransitionMinutesMap,
      amavasya: chennai_b.chennaiAmavasyaCorrections,
      purnima: chennai_b.chennaiPurnimaCorrections);
  registerCity('Srinagar',
      tithi: srinagar.srinagarTithiCorrections,
      transitions: srinagar.srinagarTransitionMinutesMap,
      amavasya: srinagar_b.srinagarAmavasyaCorrections,
      purnima: srinagar_b.srinagarPurnimaCorrections);
  registerCity('Bangalore',
      tithi: bangalore.bangaloreTithiCorrections,
      transitions: bangalore.bangaloreTransitionMinutesMap,
      amavasya: bangalore_b.bangaloreAmavasyaCorrections,
      purnima: bangalore_b.bangalorePurnimaCorrections);
  registerCity('Hyderabad',
      tithi: hyderabad.hyderabadTithiCorrections,
      transitions: hyderabad.hyderabadTransitionMinutesMap,
      amavasya: hyderabad_b.hyderabadAmavasyaCorrections,
      purnima: hyderabad_b.hyderabadPurnimaCorrections);
  registerCity('Pune',
      tithi: pune.puneTithiCorrections,
      transitions: pune.puneTransitionMinutesMap,
      amavasya: pune_b.puneAmavasyaCorrections,
      purnima: pune_b.punePurnimaCorrections);
  registerCity('Ahmedabad',
      tithi: ahmedabad.ahmedabadTithiCorrections,
      transitions: ahmedabad.ahmedabadTransitionMinutesMap,
      amavasya: ahmedabad_b.ahmedabadAmavasyaCorrections,
      purnima: ahmedabad_b.ahmedabadPurnimaCorrections);
  registerCity('Jaipur',
      tithi: jaipur.jaipurTithiCorrections,
      transitions: jaipur.jaipurTransitionMinutesMap,
      amavasya: jaipur_b.jaipurAmavasyaCorrections,
      purnima: jaipur_b.jaipurPurnimaCorrections);
  registerCity('Lucknow',
      tithi: lucknow.lucknowTithiCorrections,
      transitions: lucknow.lucknowTransitionMinutesMap,
      amavasya: lucknow_b.lucknowAmavasyaCorrections,
      purnima: lucknow_b.lucknowPurnimaCorrections);
  registerCity('Chandigarh',
      tithi: chandigarh.chandigarhTithiCorrections,
      transitions: chandigarh.chandigarhTransitionMinutesMap,
      amavasya: chandigarh_b.chandigarhAmavasyaCorrections,
      purnima: chandigarh_b.chandigarhPurnimaCorrections);
  registerCity('Jammu',
      tithi: jammu.jammuTithiCorrections,
      transitions: jammu.jammuTransitionMinutesMap,
      amavasya: jammu_b.jammuAmavasyaCorrections,
      purnima: jammu_b.jammuPurnimaCorrections);
  registerCity('Indore',
      tithi: indore.indoreTithiCorrections,
      transitions: indore.indoreTransitionMinutesMap,
      amavasya: indore_b.indoreAmavasyaCorrections,
      purnima: indore_b.indorePurnimaCorrections);
  registerCity('Ujjain',
      tithi: ujjain.ujjainTithiCorrections,
      transitions: ujjain.ujjainTransitionMinutesMap,
      amavasya: ujjain_b.ujjainAmavasyaCorrections,
      purnima: ujjain_b.ujjainPurnimaCorrections);
  registerCity('Bhopal',
      tithi: bhopal.bhopalTithiCorrections,
      transitions: bhopal.bhopalTransitionMinutesMap,
      amavasya: bhopal_b.bhopalAmavasyaCorrections,
      purnima: bhopal_b.bhopalPurnimaCorrections);
  registerCity('Nagpur',
      tithi: nagpur.nagpurTithiCorrections,
      transitions: nagpur.nagpurTransitionMinutesMap,
      amavasya: nagpur_b.nagpurAmavasyaCorrections,
      purnima: nagpur_b.nagpurPurnimaCorrections);
  registerCity('Patna',
      tithi: patna.patnaTithiCorrections,
      transitions: patna.patnaTransitionMinutesMap,
      amavasya: patna_b.patnaAmavasyaCorrections,
      purnima: patna_b.patnaPurnimaCorrections);
  registerCity('Kochi',
      tithi: kochi.kochiTithiCorrections,
      transitions: kochi.kochiTransitionMinutesMap,
      amavasya: kochi_b.kochiAmavasyaCorrections,
      purnima: kochi_b.kochiPurnimaCorrections);
  registerCity('Guwahati',
      tithi: guwahati.guwahatiTithiCorrections,
      transitions: guwahati.guwahatiTransitionMinutesMap,
      amavasya: guwahati_b.guwahatiAmavasyaCorrections,
      purnima: guwahati_b.guwahatiPurnimaCorrections);
  registerCity('Varanasi',
      tithi: varanasi.varanasiTithiCorrections,
      transitions: varanasi.varanasiTransitionMinutesMap,
      amavasya: varanasi_b.varanasiAmavasyaCorrections,
      purnima: varanasi_b.varanasiPurnimaCorrections);
  registerCity('Amritsar',
      tithi: amritsar.amritsarTithiCorrections,
      transitions: amritsar.amritsarTransitionMinutesMap,
      amavasya: amritsar_b.amritsarAmavasyaCorrections,
      purnima: amritsar_b.amritsarPurnimaCorrections);
  registerCity('Dehradun',
      tithi: dehradun.dehradunTithiCorrections,
      transitions: dehradun.dehradunTransitionMinutesMap,
      amavasya: dehradun_b.dehradunAmavasyaCorrections,
      purnima: dehradun_b.dehradunPurnimaCorrections);
  registerCity('Thiruvananthapuram',
      tithi: thiruvananthapuram.thiruvananthapuramTithiCorrections,
      transitions: thiruvananthapuram.thiruvananthapuramTransitionMinutesMap,
      amavasya: thiruvananthapuram_b.thiruvananthapuramAmavasyaCorrections,
      purnima: thiruvananthapuram_b.thiruvananthapuramPurnimaCorrections);
  registerCity('Coimbatore',
      tithi: coimbatore.coimbatoreTithiCorrections,
      transitions: coimbatore.coimbatoreTransitionMinutesMap,
      amavasya: coimbatore_b.coimbatoreAmavasyaCorrections,
      purnima: coimbatore_b.coimbatorePurnimaCorrections);
  registerCity('Visakhapatnam',
      tithi: visakhapatnam.visakhapatnamTithiCorrections,
      transitions: visakhapatnam.visakhapatnamTransitionMinutesMap,
      amavasya: visakhapatnam_b.visakhapatnamAmavasyaCorrections,
      purnima: visakhapatnam_b.visakhapatnamPurnimaCorrections);
  registerCity('Mangalore',
      tithi: mangalore.mangaloreTithiCorrections,
      transitions: mangalore.mangaloreTransitionMinutesMap,
      amavasya: mangalore_b.mangaloreAmavasyaCorrections,
      purnima: mangalore_b.mangalorePurnimaCorrections);
  registerCity('Mysore',
      tithi: mysore.mysoreTithiCorrections,
      transitions: mysore.mysoreTransitionMinutesMap,
      amavasya: mysore_b.mysoreAmavasyaCorrections,
      purnima: mysore_b.mysorePurnimaCorrections);
  registerCity('Noida',
      tithi: noida.noidaTithiCorrections,
      transitions: noida.noidaTransitionMinutesMap,
      amavasya: noida_b.noidaAmavasyaCorrections,
      purnima: noida_b.noidaPurnimaCorrections);
  registerCity('Gurgaon',
      tithi: gurgaon.gurgaonTithiCorrections,
      transitions: gurgaon.gurgaonTransitionMinutesMap,
      amavasya: gurgaon_b.gurgaonAmavasyaCorrections,
      purnima: gurgaon_b.gurgaonPurnimaCorrections);
}
