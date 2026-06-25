// GENERATED region pack — do not edit by hand.
//
/// India city correction data. Importing this file links ONLY India's
/// cities; cities outside this pack fall back to the Meeus approximation
/// unless another pack registers them.
library;

import 'package:tithi_engine/src/regions/registry.dart';
import 'package:tithi_engine/src/regions/delhi/corrections.dart' as delhi;
import 'package:tithi_engine/src/regions/mumbai/corrections.dart' as mumbai;
import 'package:tithi_engine/src/regions/kolkata/corrections.dart' as kolkata;
import 'package:tithi_engine/src/regions/chennai/corrections.dart' as chennai;
import 'package:tithi_engine/src/regions/srinagar/corrections.dart' as srinagar;
import 'package:tithi_engine/src/regions/bangalore/corrections.dart'
    as bangalore;
import 'package:tithi_engine/src/regions/hyderabad/corrections.dart'
    as hyderabad;
import 'package:tithi_engine/src/regions/pune/corrections.dart' as pune;
import 'package:tithi_engine/src/regions/ahmedabad/corrections.dart'
    as ahmedabad;
import 'package:tithi_engine/src/regions/jaipur/corrections.dart' as jaipur;
import 'package:tithi_engine/src/regions/lucknow/corrections.dart' as lucknow;
import 'package:tithi_engine/src/regions/chandigarh/corrections.dart'
    as chandigarh;
import 'package:tithi_engine/src/regions/jammu/corrections.dart' as jammu;
import 'package:tithi_engine/src/regions/indore/corrections.dart' as indore;
import 'package:tithi_engine/src/regions/ujjain/corrections.dart' as ujjain;
import 'package:tithi_engine/src/regions/bhopal/corrections.dart' as bhopal;
import 'package:tithi_engine/src/regions/nagpur/corrections.dart' as nagpur;
import 'package:tithi_engine/src/regions/patna/corrections.dart' as patna;
import 'package:tithi_engine/src/regions/kochi/corrections.dart' as kochi;
import 'package:tithi_engine/src/regions/guwahati/corrections.dart' as guwahati;
import 'package:tithi_engine/src/regions/varanasi/corrections.dart' as varanasi;
import 'package:tithi_engine/src/regions/amritsar/corrections.dart' as amritsar;
import 'package:tithi_engine/src/regions/dehradun/corrections.dart' as dehradun;
import 'package:tithi_engine/src/regions/thiruvananthapuram/corrections.dart'
    as thiruvananthapuram;
import 'package:tithi_engine/src/regions/coimbatore/corrections.dart'
    as coimbatore;
import 'package:tithi_engine/src/regions/visakhapatnam/corrections.dart'
    as visakhapatnam;
import 'package:tithi_engine/src/regions/mangalore/corrections.dart'
    as mangalore;
import 'package:tithi_engine/src/regions/mysore/corrections.dart' as mysore;
import 'package:tithi_engine/src/regions/noida/corrections.dart' as noida;
import 'package:tithi_engine/src/regions/gurgaon/corrections.dart' as gurgaon;

/// Register India's 30 cities.
bool _registered = false;
void registerIndia() {
  if (_registered) return; // idempotent: register once
  _registered = true;
  registerCity('Delhi', tithi: delhi.delhiTithiCorrections);
  registerCity('Mumbai', tithi: mumbai.mumbaiTithiCorrections);
  registerCity('Kolkata', tithi: kolkata.kolkataTithiCorrections);
  registerCity('Chennai', tithi: chennai.chennaiTithiCorrections);
  registerCity('Srinagar', tithi: srinagar.srinagarTithiCorrections);
  registerCity('Bangalore', tithi: bangalore.bangaloreTithiCorrections);
  registerCity('Hyderabad', tithi: hyderabad.hyderabadTithiCorrections);
  registerCity('Pune', tithi: pune.puneTithiCorrections);
  registerCity('Ahmedabad', tithi: ahmedabad.ahmedabadTithiCorrections);
  registerCity('Jaipur', tithi: jaipur.jaipurTithiCorrections);
  registerCity('Lucknow', tithi: lucknow.lucknowTithiCorrections);
  registerCity('Chandigarh', tithi: chandigarh.chandigarhTithiCorrections);
  registerCity('Jammu', tithi: jammu.jammuTithiCorrections);
  registerCity('Indore', tithi: indore.indoreTithiCorrections);
  registerCity('Ujjain', tithi: ujjain.ujjainTithiCorrections);
  registerCity('Bhopal', tithi: bhopal.bhopalTithiCorrections);
  registerCity('Nagpur', tithi: nagpur.nagpurTithiCorrections);
  registerCity('Patna', tithi: patna.patnaTithiCorrections);
  registerCity('Kochi', tithi: kochi.kochiTithiCorrections);
  registerCity('Guwahati', tithi: guwahati.guwahatiTithiCorrections);
  registerCity('Varanasi', tithi: varanasi.varanasiTithiCorrections);
  registerCity('Amritsar', tithi: amritsar.amritsarTithiCorrections);
  registerCity('Dehradun', tithi: dehradun.dehradunTithiCorrections);
  registerCity('Thiruvananthapuram',
      tithi: thiruvananthapuram.thiruvananthapuramTithiCorrections);
  registerCity('Coimbatore', tithi: coimbatore.coimbatoreTithiCorrections);
  registerCity('Visakhapatnam',
      tithi: visakhapatnam.visakhapatnamTithiCorrections);
  registerCity('Mangalore', tithi: mangalore.mangaloreTithiCorrections);
  registerCity('Mysore', tithi: mysore.mysoreTithiCorrections);
  registerCity('Noida', tithi: noida.noidaTithiCorrections);
  registerCity('Gurgaon', tithi: gurgaon.gurgaonTithiCorrections);
}
