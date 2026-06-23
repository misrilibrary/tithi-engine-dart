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
import 'abudhabi/boundary_corrections_center.dart' as abudhabi_b;
import 'accra/corrections_center.dart' as accra;
import 'accra/boundary_corrections_center.dart' as accra_b;
import 'addisababa/corrections_center.dart' as addisababa;
import 'addisababa/boundary_corrections_center.dart' as addisababa_b;
import 'adelaide/corrections_center.dart' as adelaide;
import 'adelaide/boundary_corrections_center.dart' as adelaide_b;
import 'agra/corrections_center.dart' as agra;
import 'agra/boundary_corrections_center.dart' as agra_b;
import 'ahmedabad/corrections_center.dart' as ahmedabad;
import 'ahmedabad/boundary_corrections_center.dart' as ahmedabad_b;
import 'allahabad/corrections_center.dart' as allahabad;
import 'allahabad/boundary_corrections_center.dart' as allahabad_b;
import 'almaty/corrections_center.dart' as almaty;
import 'almaty/boundary_corrections_center.dart' as almaty_b;
import 'amman/corrections_center.dart' as amman;
import 'amman/boundary_corrections_center.dart' as amman_b;
import 'amritsar/corrections_center.dart' as amritsar;
import 'amritsar/boundary_corrections_center.dart' as amritsar_b;
import 'amsterdam/corrections_center.dart' as amsterdam;
import 'amsterdam/boundary_corrections_center.dart' as amsterdam_b;
import 'ankara/corrections_center.dart' as ankara;
import 'ankara/boundary_corrections_center.dart' as ankara_b;
import 'athens/corrections_center.dart' as athens;
import 'athens/boundary_corrections_center.dart' as athens_b;
import 'atlanta/corrections_center.dart' as atlanta;
import 'atlanta/boundary_corrections_center.dart' as atlanta_b;
import 'auckland/corrections_center.dart' as auckland;
import 'auckland/boundary_corrections_center.dart' as auckland_b;
import 'aurangabad/corrections_center.dart' as aurangabad;
import 'aurangabad/boundary_corrections_center.dart' as aurangabad_b;
import 'austin/corrections_center.dart' as austin;
import 'austin/boundary_corrections_center.dart' as austin_b;
import 'ayodhya/corrections_center.dart' as ayodhya;
import 'ayodhya/boundary_corrections_center.dart' as ayodhya_b;
import 'bahrain/corrections_center.dart' as bahrain;
import 'bahrain/boundary_corrections_center.dart' as bahrain_b;
import 'bangalore/corrections_center.dart' as bangalore;
import 'bangalore/boundary_corrections_center.dart' as bangalore_b;
import 'bangkok/corrections_center.dart' as bangkok;
import 'bangkok/boundary_corrections_center.dart' as bangkok_b;
import 'barcelona/corrections_center.dart' as barcelona;
import 'barcelona/boundary_corrections_center.dart' as barcelona_b;
import 'beijing/corrections_center.dart' as beijing;
import 'beijing/boundary_corrections_center.dart' as beijing_b;
import 'beirut/corrections_center.dart' as beirut;
import 'beirut/boundary_corrections_center.dart' as beirut_b;
import 'berlin/corrections_center.dart' as berlin;
import 'berlin/boundary_corrections_center.dart' as berlin_b;
import 'bhopal/corrections_center.dart' as bhopal;
import 'bhopal/boundary_corrections_center.dart' as bhopal_b;
import 'bhubaneswar/corrections_center.dart' as bhubaneswar;
import 'bhubaneswar/boundary_corrections_center.dart' as bhubaneswar_b;
import 'birmingham/corrections_center.dart' as birmingham;
import 'birmingham/boundary_corrections_center.dart' as birmingham_b;
import 'bogot/corrections_center.dart' as bogot;
import 'bogot/boundary_corrections_center.dart' as bogot_b;
import 'boston/corrections_center.dart' as boston;
import 'boston/boundary_corrections_center.dart' as boston_b;
import 'brampton/corrections_center.dart' as brampton;
import 'brampton/boundary_corrections_center.dart' as brampton_b;
import 'brisbane/corrections_center.dart' as brisbane;
import 'brisbane/boundary_corrections_center.dart' as brisbane_b;
import 'brussels/corrections_center.dart' as brussels;
import 'brussels/boundary_corrections_center.dart' as brussels_b;
import 'bucharest/corrections_center.dart' as bucharest;
import 'bucharest/boundary_corrections_center.dart' as bucharest_b;
import 'budapest/corrections_center.dart' as budapest;
import 'budapest/boundary_corrections_center.dart' as budapest_b;
import 'buenosaires/corrections_center.dart' as buenosaires;
import 'buenosaires/boundary_corrections_center.dart' as buenosaires_b;
import 'cairo/corrections_center.dart' as cairo;
import 'cairo/boundary_corrections_center.dart' as cairo_b;
import 'calgary/corrections_center.dart' as calgary;
import 'calgary/boundary_corrections_center.dart' as calgary_b;
import 'canberra/corrections_center.dart' as canberra;
import 'canberra/boundary_corrections_center.dart' as canberra_b;
import 'capetown/corrections_center.dart' as capetown;
import 'capetown/boundary_corrections_center.dart' as capetown_b;
import 'chandigarh/corrections_center.dart' as chandigarh;
import 'chandigarh/boundary_corrections_center.dart' as chandigarh_b;
import 'charlotte/corrections_center.dart' as charlotte;
import 'charlotte/boundary_corrections_center.dart' as charlotte_b;
import 'chennai/corrections_center.dart' as chennai;
import 'chennai/boundary_corrections_center.dart' as chennai_b;
import 'chicago/corrections_center.dart' as chicago;
import 'chicago/boundary_corrections_center.dart' as chicago_b;
import 'coimbatore/corrections_center.dart' as coimbatore;
import 'coimbatore/boundary_corrections_center.dart' as coimbatore_b;
import 'colombo/corrections_center.dart' as colombo;
import 'colombo/boundary_corrections_center.dart' as colombo_b;
import 'columbus/corrections_center.dart' as columbus;
import 'columbus/boundary_corrections_center.dart' as columbus_b;
import 'copenhagen/corrections_center.dart' as copenhagen;
import 'copenhagen/boundary_corrections_center.dart' as copenhagen_b;
import 'dallas/corrections_center.dart' as dallas;
import 'dallas/boundary_corrections_center.dart' as dallas_b;
import 'daressalaam/corrections_center.dart' as daressalaam;
import 'daressalaam/boundary_corrections_center.dart' as daressalaam_b;
import 'dehradun/corrections_center.dart' as dehradun;
import 'dehradun/boundary_corrections_center.dart' as dehradun_b;
import 'delhi/corrections_center.dart' as delhi;
import 'delhi/boundary_corrections_center.dart' as delhi_b;
import 'denpasar/corrections_center.dart' as denpasar;
import 'denpasar/boundary_corrections_center.dart' as denpasar_b;
import 'denver/corrections_center.dart' as denver;
import 'denver/boundary_corrections_center.dart' as denver_b;
import 'detroit/corrections_center.dart' as detroit;
import 'detroit/boundary_corrections_center.dart' as detroit_b;
import 'dhaka/corrections_center.dart' as dhaka;
import 'dhaka/boundary_corrections_center.dart' as dhaka_b;
import 'doha/corrections_center.dart' as doha;
import 'doha/boundary_corrections_center.dart' as doha_b;
import 'dubai/corrections_center.dart' as dubai;
import 'dubai/boundary_corrections_center.dart' as dubai_b;
import 'dublin/corrections_center.dart' as dublin;
import 'dublin/boundary_corrections_center.dart' as dublin_b;
import 'durban/corrections_center.dart' as durban;
import 'durban/boundary_corrections_center.dart' as durban_b;
import 'dwarka/corrections_center.dart' as dwarka;
import 'dwarka/boundary_corrections_center.dart' as dwarka_b;
import 'edinburgh/corrections_center.dart' as edinburgh;
import 'edinburgh/boundary_corrections_center.dart' as edinburgh_b;
import 'edmonton/corrections_center.dart' as edmonton;
import 'edmonton/boundary_corrections_center.dart' as edmonton_b;
import 'faridabad/corrections_center.dart' as faridabad;
import 'faridabad/boundary_corrections_center.dart' as faridabad_b;
import 'fremont/corrections_center.dart' as fremont;
import 'fremont/boundary_corrections_center.dart' as fremont_b;
import 'georgetown/corrections_center.dart' as georgetown;
import 'georgetown/boundary_corrections_center.dart' as georgetown_b;
import 'ghaziabad/corrections_center.dart' as ghaziabad;
import 'ghaziabad/boundary_corrections_center.dart' as ghaziabad_b;
import 'glasgow/corrections_center.dart' as glasgow;
import 'glasgow/boundary_corrections_center.dart' as glasgow_b;
import 'gorakhpur/corrections_center.dart' as gorakhpur;
import 'gorakhpur/boundary_corrections_center.dart' as gorakhpur_b;
import 'gothenburg/corrections_center.dart' as gothenburg;
import 'gothenburg/boundary_corrections_center.dart' as gothenburg_b;
import 'gurgaon/corrections_center.dart' as gurgaon;
import 'gurgaon/boundary_corrections_center.dart' as gurgaon_b;
import 'guwahati/corrections_center.dart' as guwahati;
import 'guwahati/boundary_corrections_center.dart' as guwahati_b;
import 'gwalior/corrections_center.dart' as gwalior;
import 'gwalior/boundary_corrections_center.dart' as gwalior_b;
import 'halifax/corrections_center.dart' as halifax;
import 'halifax/boundary_corrections_center.dart' as halifax_b;
import 'hanoi/corrections_center.dart' as hanoi;
import 'hanoi/boundary_corrections_center.dart' as hanoi_b;
import 'haridwar/corrections_center.dart' as haridwar;
import 'haridwar/boundary_corrections_center.dart' as haridwar_b;
import 'helsinki/corrections_center.dart' as helsinki;
import 'helsinki/boundary_corrections_center.dart' as helsinki_b;
import 'hochiminhcity/corrections_center.dart' as hochiminhcity;
import 'hochiminhcity/boundary_corrections_center.dart' as hochiminhcity_b;
import 'hongkong/corrections_center.dart' as hongkong;
import 'hongkong/boundary_corrections_center.dart' as hongkong_b;
import 'honolulu/corrections_center.dart' as honolulu;
import 'honolulu/boundary_corrections_center.dart' as honolulu_b;
import 'houston/corrections_center.dart' as houston;
import 'houston/boundary_corrections_center.dart' as houston_b;
import 'hubli/corrections_center.dart' as hubli;
import 'hubli/boundary_corrections_center.dart' as hubli_b;
import 'hyderabad/corrections_center.dart' as hyderabad;
import 'hyderabad/boundary_corrections_center.dart' as hyderabad_b;
import 'indianapolis/corrections_center.dart' as indianapolis;
import 'indianapolis/boundary_corrections_center.dart' as indianapolis_b;
import 'indore/corrections_center.dart' as indore;
import 'indore/boundary_corrections_center.dart' as indore_b;
import 'islamabad/corrections_center.dart' as islamabad;
import 'islamabad/boundary_corrections_center.dart' as islamabad_b;
import 'istanbul/corrections_center.dart' as istanbul;
import 'istanbul/boundary_corrections_center.dart' as istanbul_b;
import 'jabalpur/corrections_center.dart' as jabalpur;
import 'jabalpur/boundary_corrections_center.dart' as jabalpur_b;
import 'jaipur/corrections_center.dart' as jaipur;
import 'jaipur/boundary_corrections_center.dart' as jaipur_b;
import 'jakarta/corrections_center.dart' as jakarta;
import 'jakarta/boundary_corrections_center.dart' as jakarta_b;
import 'jalandhar/corrections_center.dart' as jalandhar;
import 'jalandhar/boundary_corrections_center.dart' as jalandhar_b;
import 'jammu/corrections_center.dart' as jammu;
import 'jammu/boundary_corrections_center.dart' as jammu_b;
import 'jeddah/corrections_center.dart' as jeddah;
import 'jeddah/boundary_corrections_center.dart' as jeddah_b;
import 'jodhpur/corrections_center.dart' as jodhpur;
import 'jodhpur/boundary_corrections_center.dart' as jodhpur_b;
import 'johannesburg/corrections_center.dart' as johannesburg;
import 'johannesburg/boundary_corrections_center.dart' as johannesburg_b;
import 'kampala/corrections_center.dart' as kampala;
import 'kampala/boundary_corrections_center.dart' as kampala_b;
import 'kanpur/corrections_center.dart' as kanpur;
import 'kanpur/boundary_corrections_center.dart' as kanpur_b;
import 'kansascity/corrections_center.dart' as kansascity;
import 'kansascity/boundary_corrections_center.dart' as kansascity_b;
import 'karachi/corrections_center.dart' as karachi;
import 'karachi/boundary_corrections_center.dart' as karachi_b;
import 'kathmandu/corrections_center.dart' as kathmandu;
import 'kathmandu/boundary_corrections_center.dart' as kathmandu_b;
import 'kingston/corrections_center.dart' as kingston;
import 'kingston/boundary_corrections_center.dart' as kingston_b;
import 'kirkland/corrections_center.dart' as kirkland;
import 'kirkland/boundary_corrections_center.dart' as kirkland_b;
import 'kochi/corrections_center.dart' as kochi;
import 'kochi/boundary_corrections_center.dart' as kochi_b;
import 'kolkata/corrections_center.dart' as kolkata;
import 'kolkata/boundary_corrections_center.dart' as kolkata_b;
import 'kota/corrections_center.dart' as kota;
import 'kota/boundary_corrections_center.dart' as kota_b;
import 'krakow/corrections_center.dart' as krakow;
import 'krakow/boundary_corrections_center.dart' as krakow_b;
import 'kualalumpur/corrections_center.dart' as kualalumpur;
import 'kualalumpur/boundary_corrections_center.dart' as kualalumpur_b;
import 'kuwaitcity/corrections_center.dart' as kuwaitcity;
import 'kuwaitcity/boundary_corrections_center.dart' as kuwaitcity_b;
import 'kyiv/corrections_center.dart' as kyiv;
import 'kyiv/boundary_corrections_center.dart' as kyiv_b;
import 'lagos/corrections_center.dart' as lagos;
import 'lagos/boundary_corrections_center.dart' as lagos_b;
import 'lahore/corrections_center.dart' as lahore;
import 'lahore/boundary_corrections_center.dart' as lahore_b;
import 'lasvegas/corrections_center.dart' as lasvegas;
import 'lasvegas/boundary_corrections_center.dart' as lasvegas_b;
import 'leicester/corrections_center.dart' as leicester;
import 'leicester/boundary_corrections_center.dart' as leicester_b;
import 'lima/corrections_center.dart' as lima;
import 'lima/boundary_corrections_center.dart' as lima_b;
import 'lisbon/corrections_center.dart' as lisbon;
import 'lisbon/boundary_corrections_center.dart' as lisbon_b;
import 'london/corrections_center.dart' as london;
import 'london/boundary_corrections_center.dart' as london_b;
import 'losangeles/corrections_center.dart' as losangeles;
import 'losangeles/boundary_corrections_center.dart' as losangeles_b;
import 'lucknow/corrections_center.dart' as lucknow;
import 'lucknow/boundary_corrections_center.dart' as lucknow_b;
import 'ludhiana/corrections_center.dart' as ludhiana;
import 'ludhiana/boundary_corrections_center.dart' as ludhiana_b;
import 'lyon/corrections_center.dart' as lyon;
import 'lyon/boundary_corrections_center.dart' as lyon_b;
import 'madrid/corrections_center.dart' as madrid;
import 'madrid/boundary_corrections_center.dart' as madrid_b;
import 'madurai/corrections_center.dart' as madurai;
import 'madurai/boundary_corrections_center.dart' as madurai_b;
import 'manchester/corrections_center.dart' as manchester;
import 'manchester/boundary_corrections_center.dart' as manchester_b;
import 'mangalore/corrections_center.dart' as mangalore;
import 'mangalore/boundary_corrections_center.dart' as mangalore_b;
import 'manila/corrections_center.dart' as manila;
import 'manila/boundary_corrections_center.dart' as manila_b;
import 'mathura/corrections_center.dart' as mathura;
import 'mathura/boundary_corrections_center.dart' as mathura_b;
import 'medellin/corrections_center.dart' as medellin;
import 'medellin/boundary_corrections_center.dart' as medellin_b;
import 'meerut/corrections_center.dart' as meerut;
import 'meerut/boundary_corrections_center.dart' as meerut_b;
import 'melbourne/corrections_center.dart' as melbourne;
import 'melbourne/boundary_corrections_center.dart' as melbourne_b;
import 'mexicocity/corrections_center.dart' as mexicocity;
import 'mexicocity/boundary_corrections_center.dart' as mexicocity_b;
import 'miami/corrections_center.dart' as miami;
import 'miami/boundary_corrections_center.dart' as miami_b;
import 'milan/corrections_center.dart' as milan;
import 'milan/boundary_corrections_center.dart' as milan_b;
import 'minneapolis/corrections_center.dart' as minneapolis;
import 'minneapolis/boundary_corrections_center.dart' as minneapolis_b;
import 'mississauga/corrections_center.dart' as mississauga;
import 'mississauga/boundary_corrections_center.dart' as mississauga_b;
import 'mombasa/corrections_center.dart' as mombasa;
import 'mombasa/boundary_corrections_center.dart' as mombasa_b;
import 'montreal/corrections_center.dart' as montreal;
import 'montreal/boundary_corrections_center.dart' as montreal_b;
import 'moscow/corrections_center.dart' as moscow;
import 'moscow/boundary_corrections_center.dart' as moscow_b;
import 'mumbai/corrections_center.dart' as mumbai;
import 'mumbai/boundary_corrections_center.dart' as mumbai_b;
import 'munich/corrections_center.dart' as munich;
import 'munich/boundary_corrections_center.dart' as munich_b;
import 'muscat/corrections_center.dart' as muscat;
import 'muscat/boundary_corrections_center.dart' as muscat_b;
import 'mussoorie/corrections_center.dart' as mussoorie;
import 'mussoorie/boundary_corrections_center.dart' as mussoorie_b;
import 'mysore/corrections_center.dart' as mysore;
import 'mysore/boundary_corrections_center.dart' as mysore_b;
import 'nagpur/corrections_center.dart' as nagpur;
import 'nagpur/boundary_corrections_center.dart' as nagpur_b;
import 'nairobi/corrections_center.dart' as nairobi;
import 'nairobi/boundary_corrections_center.dart' as nairobi_b;
import 'naples/corrections_center.dart' as naples;
import 'naples/boundary_corrections_center.dart' as naples_b;
import 'nashik/corrections_center.dart' as nashik;
import 'nashik/boundary_corrections_center.dart' as nashik_b;
import 'nashville/corrections_center.dart' as nashville;
import 'nashville/boundary_corrections_center.dart' as nashville_b;
import 'newyork/corrections_center.dart' as newyork;
import 'newyork/boundary_corrections_center.dart' as newyork_b;
import 'noida/corrections_center.dart' as noida;
import 'noida/boundary_corrections_center.dart' as noida_b;
import 'orlando/corrections_center.dart' as orlando;
import 'orlando/boundary_corrections_center.dart' as orlando_b;
import 'osaka/corrections_center.dart' as osaka;
import 'osaka/boundary_corrections_center.dart' as osaka_b;
import 'oslo/corrections_center.dart' as oslo;
import 'oslo/boundary_corrections_center.dart' as oslo_b;
import 'ottawa/corrections_center.dart' as ottawa;
import 'ottawa/boundary_corrections_center.dart' as ottawa_b;
import 'panamacity/corrections_center.dart' as panamacity;
import 'panamacity/boundary_corrections_center.dart' as panamacity_b;
import 'paramaribo/corrections_center.dart' as paramaribo;
import 'paramaribo/boundary_corrections_center.dart' as paramaribo_b;
import 'paris/corrections_center.dart' as paris;
import 'paris/boundary_corrections_center.dart' as paris_b;
import 'patna/corrections_center.dart' as patna;
import 'patna/boundary_corrections_center.dart' as patna_b;
import 'perth/corrections_center.dart' as perth;
import 'perth/boundary_corrections_center.dart' as perth_b;
import 'philadelphia/corrections_center.dart' as philadelphia;
import 'philadelphia/boundary_corrections_center.dart' as philadelphia_b;
import 'phnompenh/corrections_center.dart' as phnompenh;
import 'phnompenh/boundary_corrections_center.dart' as phnompenh_b;
import 'phoenix/corrections_center.dart' as phoenix;
import 'phoenix/boundary_corrections_center.dart' as phoenix_b;
import 'pittsburgh/corrections_center.dart' as pittsburgh;
import 'pittsburgh/boundary_corrections_center.dart' as pittsburgh_b;
import 'portland/corrections_center.dart' as portland;
import 'portland/boundary_corrections_center.dart' as portland_b;
import 'portlouis/corrections_center.dart' as portlouis;
import 'portlouis/boundary_corrections_center.dart' as portlouis_b;
import 'porto/corrections_center.dart' as porto;
import 'porto/boundary_corrections_center.dart' as porto_b;
import 'portofspain/corrections_center.dart' as portofspain;
import 'portofspain/boundary_corrections_center.dart' as portofspain_b;
import 'prague/corrections_center.dart' as prague;
import 'prague/boundary_corrections_center.dart' as prague_b;
import 'prayagraj/corrections_center.dart' as prayagraj;
import 'prayagraj/boundary_corrections_center.dart' as prayagraj_b;
import 'pune/corrections_center.dart' as pune;
import 'pune/boundary_corrections_center.dart' as pune_b;
import 'quito/corrections_center.dart' as quito;
import 'quito/boundary_corrections_center.dart' as quito_b;
import 'raipur/corrections_center.dart' as raipur;
import 'raipur/boundary_corrections_center.dart' as raipur_b;
import 'rajkot/corrections_center.dart' as rajkot;
import 'rajkot/boundary_corrections_center.dart' as rajkot_b;
import 'raleigh/corrections_center.dart' as raleigh;
import 'raleigh/boundary_corrections_center.dart' as raleigh_b;
import 'ranchi/corrections_center.dart' as ranchi;
import 'ranchi/boundary_corrections_center.dart' as ranchi_b;
import 'redmond/corrections_center.dart' as redmond;
import 'redmond/boundary_corrections_center.dart' as redmond_b;
import 'regina/corrections_center.dart' as regina;
import 'regina/boundary_corrections_center.dart' as regina_b;
import 'riodejaneiro/corrections_center.dart' as riodejaneiro;
import 'riodejaneiro/boundary_corrections_center.dart' as riodejaneiro_b;
import 'rishikesh/corrections_center.dart' as rishikesh;
import 'rishikesh/boundary_corrections_center.dart' as rishikesh_b;
import 'riyadh/corrections_center.dart' as riyadh;
import 'riyadh/boundary_corrections_center.dart' as riyadh_b;
import 'rome/corrections_center.dart' as rome;
import 'rome/boundary_corrections_center.dart' as rome_b;
import 'rotterdam/corrections_center.dart' as rotterdam;
import 'rotterdam/boundary_corrections_center.dart' as rotterdam_b;
import 'sacramento/corrections_center.dart' as sacramento;
import 'sacramento/boundary_corrections_center.dart' as sacramento_b;
import 'salem/corrections_center.dart' as salem;
import 'salem/boundary_corrections_center.dart' as salem_b;
import 'saltlakecity/corrections_center.dart' as saltlakecity;
import 'saltlakecity/boundary_corrections_center.dart' as saltlakecity_b;
import 'sandiego/corrections_center.dart' as sandiego;
import 'sandiego/boundary_corrections_center.dart' as sandiego_b;
import 'sanfrancisco/corrections_center.dart' as sanfrancisco;
import 'sanfrancisco/boundary_corrections_center.dart' as sanfrancisco_b;
import 'sanjose/corrections_center.dart' as sanjose;
import 'sanjose/boundary_corrections_center.dart' as sanjose_b;
import 'santiago/corrections_center.dart' as santiago;
import 'santiago/boundary_corrections_center.dart' as santiago_b;
import 'seattle/corrections_center.dart' as seattle;
import 'seattle/boundary_corrections_center.dart' as seattle_b;
import 'seoul/corrections_center.dart' as seoul;
import 'seoul/boundary_corrections_center.dart' as seoul_b;
import 'shanghai/corrections_center.dart' as shanghai;
import 'shanghai/boundary_corrections_center.dart' as shanghai_b;
import 'shirdi/corrections_center.dart' as shirdi;
import 'shirdi/boundary_corrections_center.dart' as shirdi_b;
import 'singapore/corrections_center.dart' as singapore;
import 'singapore/boundary_corrections_center.dart' as singapore_b;
import 'sofia/corrections_center.dart' as sofia;
import 'sofia/boundary_corrections_center.dart' as sofia_b;
import 'sopaulo/corrections_center.dart' as sopaulo;
import 'sopaulo/boundary_corrections_center.dart' as sopaulo_b;
import 'srinagar/corrections_center.dart' as srinagar;
import 'srinagar/boundary_corrections_center.dart' as srinagar_b;
import 'stlouis/corrections_center.dart' as stlouis;
import 'stlouis/boundary_corrections_center.dart' as stlouis_b;
import 'stockholm/corrections_center.dart' as stockholm;
import 'stockholm/boundary_corrections_center.dart' as stockholm_b;
import 'surat/corrections_center.dart' as surat;
import 'surat/boundary_corrections_center.dart' as surat_b;
import 'surrey/corrections_center.dart' as surrey;
import 'surrey/boundary_corrections_center.dart' as surrey_b;
import 'suva/corrections_center.dart' as suva;
import 'suva/boundary_corrections_center.dart' as suva_b;
import 'sydney/corrections_center.dart' as sydney;
import 'sydney/boundary_corrections_center.dart' as sydney_b;
import 'taipei/corrections_center.dart' as taipei;
import 'taipei/boundary_corrections_center.dart' as taipei_b;
import 'tampa/corrections_center.dart' as tampa;
import 'tampa/boundary_corrections_center.dart' as tampa_b;
import 'tashkent/corrections_center.dart' as tashkent;
import 'tashkent/boundary_corrections_center.dart' as tashkent_b;
import 'telaviv/corrections_center.dart' as telaviv;
import 'telaviv/boundary_corrections_center.dart' as telaviv_b;
import 'thane/corrections_center.dart' as thane;
import 'thane/boundary_corrections_center.dart' as thane_b;
import 'thessaloniki/corrections_center.dart' as thessaloniki;
import 'thessaloniki/boundary_corrections_center.dart' as thessaloniki_b;
import 'thiruvananthapuram/corrections_center.dart' as thiruvananthapuram;
import 'thiruvananthapuram/boundary_corrections_center.dart'
    as thiruvananthapuram_b;
import 'tiruchirappalli/corrections_center.dart' as tiruchirappalli;
import 'tiruchirappalli/boundary_corrections_center.dart' as tiruchirappalli_b;
import 'tirupati/corrections_center.dart' as tirupati;
import 'tirupati/boundary_corrections_center.dart' as tirupati_b;
import 'tokyo/corrections_center.dart' as tokyo;
import 'tokyo/boundary_corrections_center.dart' as tokyo_b;
import 'toronto/corrections_center.dart' as toronto;
import 'toronto/boundary_corrections_center.dart' as toronto_b;
import 'udaipur/corrections_center.dart' as udaipur;
import 'udaipur/boundary_corrections_center.dart' as udaipur_b;
import 'ujjain/corrections_center.dart' as ujjain;
import 'ujjain/boundary_corrections_center.dart' as ujjain_b;
import 'vadodara/corrections_center.dart' as vadodara;
import 'vadodara/boundary_corrections_center.dart' as vadodara_b;
import 'vancouver/corrections_center.dart' as vancouver;
import 'vancouver/boundary_corrections_center.dart' as vancouver_b;
import 'varanasi/corrections_center.dart' as varanasi;
import 'varanasi/boundary_corrections_center.dart' as varanasi_b;
import 'vienna/corrections_center.dart' as vienna;
import 'vienna/boundary_corrections_center.dart' as vienna_b;
import 'vijayawada/corrections_center.dart' as vijayawada;
import 'vijayawada/boundary_corrections_center.dart' as vijayawada_b;
import 'visakhapatnam/corrections_center.dart' as visakhapatnam;
import 'visakhapatnam/boundary_corrections_center.dart' as visakhapatnam_b;
import 'vrindavan/corrections_center.dart' as vrindavan;
import 'vrindavan/boundary_corrections_center.dart' as vrindavan_b;
import 'warangal/corrections_center.dart' as warangal;
import 'warangal/boundary_corrections_center.dart' as warangal_b;
import 'warsaw/corrections_center.dart' as warsaw;
import 'warsaw/boundary_corrections_center.dart' as warsaw_b;
import 'washingtondc/corrections_center.dart' as washingtondc;
import 'washingtondc/boundary_corrections_center.dart' as washingtondc_b;
import 'wellington/corrections_center.dart' as wellington;
import 'wellington/boundary_corrections_center.dart' as wellington_b;
import 'winnipeg/corrections_center.dart' as winnipeg;
import 'winnipeg/boundary_corrections_center.dart' as winnipeg_b;
import 'yangon/corrections_center.dart' as yangon;
import 'yangon/boundary_corrections_center.dart' as yangon_b;
import 'zagreb/corrections_center.dart' as zagreb;
import 'zagreb/boundary_corrections_center.dart' as zagreb_b;
import 'zurich/corrections_center.dart' as zurich;
import 'zurich/boundary_corrections_center.dart' as zurich_b;

/// Register centerDisc tables for all 230 cities.
bool _registered = false;
void registerAllCitiesCenterDisc() {
  if (_registered) return; // idempotent
  _registered = true;
  registerCity('Abu Dhabi',
      tithi: abudhabi.abudhabiTithiCorrectionsCenter,
      amavasya: abudhabi_b.abudhabiAmavasyaCorrectionsCenter,
      purnima: abudhabi_b.abudhabiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Accra',
      tithi: accra.accraTithiCorrectionsCenter,
      amavasya: accra_b.accraAmavasyaCorrectionsCenter,
      purnima: accra_b.accraPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Addis Ababa',
      tithi: addisababa.addisababaTithiCorrectionsCenter,
      amavasya: addisababa_b.addisababaAmavasyaCorrectionsCenter,
      purnima: addisababa_b.addisababaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Adelaide',
      tithi: adelaide.adelaideTithiCorrectionsCenter,
      amavasya: adelaide_b.adelaideAmavasyaCorrectionsCenter,
      purnima: adelaide_b.adelaidePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Agra',
      tithi: agra.agraTithiCorrectionsCenter,
      amavasya: agra_b.agraAmavasyaCorrectionsCenter,
      purnima: agra_b.agraPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ahmedabad',
      tithi: ahmedabad.ahmedabadTithiCorrectionsCenter,
      amavasya: ahmedabad_b.ahmedabadAmavasyaCorrectionsCenter,
      purnima: ahmedabad_b.ahmedabadPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Allahabad',
      tithi: allahabad.allahabadTithiCorrectionsCenter,
      amavasya: allahabad_b.allahabadAmavasyaCorrectionsCenter,
      purnima: allahabad_b.allahabadPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Almaty',
      tithi: almaty.almatyTithiCorrectionsCenter,
      amavasya: almaty_b.almatyAmavasyaCorrectionsCenter,
      purnima: almaty_b.almatyPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Amman',
      tithi: amman.ammanTithiCorrectionsCenter,
      amavasya: amman_b.ammanAmavasyaCorrectionsCenter,
      purnima: amman_b.ammanPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Amritsar',
      tithi: amritsar.amritsarTithiCorrectionsCenter,
      amavasya: amritsar_b.amritsarAmavasyaCorrectionsCenter,
      purnima: amritsar_b.amritsarPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Amsterdam',
      tithi: amsterdam.amsterdamTithiCorrectionsCenter,
      amavasya: amsterdam_b.amsterdamAmavasyaCorrectionsCenter,
      purnima: amsterdam_b.amsterdamPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ankara',
      tithi: ankara.ankaraTithiCorrectionsCenter,
      amavasya: ankara_b.ankaraAmavasyaCorrectionsCenter,
      purnima: ankara_b.ankaraPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Athens',
      tithi: athens.athensTithiCorrectionsCenter,
      amavasya: athens_b.athensAmavasyaCorrectionsCenter,
      purnima: athens_b.athensPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Atlanta',
      tithi: atlanta.atlantaTithiCorrectionsCenter,
      amavasya: atlanta_b.atlantaAmavasyaCorrectionsCenter,
      purnima: atlanta_b.atlantaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Auckland',
      tithi: auckland.aucklandTithiCorrectionsCenter,
      amavasya: auckland_b.aucklandAmavasyaCorrectionsCenter,
      purnima: auckland_b.aucklandPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Aurangabad',
      tithi: aurangabad.aurangabadTithiCorrectionsCenter,
      amavasya: aurangabad_b.aurangabadAmavasyaCorrectionsCenter,
      purnima: aurangabad_b.aurangabadPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Austin',
      tithi: austin.austinTithiCorrectionsCenter,
      amavasya: austin_b.austinAmavasyaCorrectionsCenter,
      purnima: austin_b.austinPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ayodhya',
      tithi: ayodhya.ayodhyaTithiCorrectionsCenter,
      amavasya: ayodhya_b.ayodhyaAmavasyaCorrectionsCenter,
      purnima: ayodhya_b.ayodhyaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bahrain',
      tithi: bahrain.bahrainTithiCorrectionsCenter,
      amavasya: bahrain_b.bahrainAmavasyaCorrectionsCenter,
      purnima: bahrain_b.bahrainPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bangalore',
      tithi: bangalore.bangaloreTithiCorrectionsCenter,
      amavasya: bangalore_b.bangaloreAmavasyaCorrectionsCenter,
      purnima: bangalore_b.bangalorePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bangkok',
      tithi: bangkok.bangkokTithiCorrectionsCenter,
      amavasya: bangkok_b.bangkokAmavasyaCorrectionsCenter,
      purnima: bangkok_b.bangkokPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Barcelona',
      tithi: barcelona.barcelonaTithiCorrectionsCenter,
      amavasya: barcelona_b.barcelonaAmavasyaCorrectionsCenter,
      purnima: barcelona_b.barcelonaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Beijing',
      tithi: beijing.beijingTithiCorrectionsCenter,
      amavasya: beijing_b.beijingAmavasyaCorrectionsCenter,
      purnima: beijing_b.beijingPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Beirut',
      tithi: beirut.beirutTithiCorrectionsCenter,
      amavasya: beirut_b.beirutAmavasyaCorrectionsCenter,
      purnima: beirut_b.beirutPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Berlin',
      tithi: berlin.berlinTithiCorrectionsCenter,
      amavasya: berlin_b.berlinAmavasyaCorrectionsCenter,
      purnima: berlin_b.berlinPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bhopal',
      tithi: bhopal.bhopalTithiCorrectionsCenter,
      amavasya: bhopal_b.bhopalAmavasyaCorrectionsCenter,
      purnima: bhopal_b.bhopalPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bhubaneswar',
      tithi: bhubaneswar.bhubaneswarTithiCorrectionsCenter,
      amavasya: bhubaneswar_b.bhubaneswarAmavasyaCorrectionsCenter,
      purnima: bhubaneswar_b.bhubaneswarPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Birmingham',
      tithi: birmingham.birminghamTithiCorrectionsCenter,
      amavasya: birmingham_b.birminghamAmavasyaCorrectionsCenter,
      purnima: birmingham_b.birminghamPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bogotá',
      tithi: bogot.bogotTithiCorrectionsCenter,
      amavasya: bogot_b.bogotAmavasyaCorrectionsCenter,
      purnima: bogot_b.bogotPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Boston',
      tithi: boston.bostonTithiCorrectionsCenter,
      amavasya: boston_b.bostonAmavasyaCorrectionsCenter,
      purnima: boston_b.bostonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Brampton',
      tithi: brampton.bramptonTithiCorrectionsCenter,
      amavasya: brampton_b.bramptonAmavasyaCorrectionsCenter,
      purnima: brampton_b.bramptonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Brisbane',
      tithi: brisbane.brisbaneTithiCorrectionsCenter,
      amavasya: brisbane_b.brisbaneAmavasyaCorrectionsCenter,
      purnima: brisbane_b.brisbanePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Brussels',
      tithi: brussels.brusselsTithiCorrectionsCenter,
      amavasya: brussels_b.brusselsAmavasyaCorrectionsCenter,
      purnima: brussels_b.brusselsPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Bucharest',
      tithi: bucharest.bucharestTithiCorrectionsCenter,
      amavasya: bucharest_b.bucharestAmavasyaCorrectionsCenter,
      purnima: bucharest_b.bucharestPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Budapest',
      tithi: budapest.budapestTithiCorrectionsCenter,
      amavasya: budapest_b.budapestAmavasyaCorrectionsCenter,
      purnima: budapest_b.budapestPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Buenos Aires',
      tithi: buenosaires.buenosairesTithiCorrectionsCenter,
      amavasya: buenosaires_b.buenosairesAmavasyaCorrectionsCenter,
      purnima: buenosaires_b.buenosairesPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Cairo',
      tithi: cairo.cairoTithiCorrectionsCenter,
      amavasya: cairo_b.cairoAmavasyaCorrectionsCenter,
      purnima: cairo_b.cairoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Calgary',
      tithi: calgary.calgaryTithiCorrectionsCenter,
      amavasya: calgary_b.calgaryAmavasyaCorrectionsCenter,
      purnima: calgary_b.calgaryPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Canberra',
      tithi: canberra.canberraTithiCorrectionsCenter,
      amavasya: canberra_b.canberraAmavasyaCorrectionsCenter,
      purnima: canberra_b.canberraPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Cape Town',
      tithi: capetown.capetownTithiCorrectionsCenter,
      amavasya: capetown_b.capetownAmavasyaCorrectionsCenter,
      purnima: capetown_b.capetownPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Chandigarh',
      tithi: chandigarh.chandigarhTithiCorrectionsCenter,
      amavasya: chandigarh_b.chandigarhAmavasyaCorrectionsCenter,
      purnima: chandigarh_b.chandigarhPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Charlotte',
      tithi: charlotte.charlotteTithiCorrectionsCenter,
      amavasya: charlotte_b.charlotteAmavasyaCorrectionsCenter,
      purnima: charlotte_b.charlottePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Chennai',
      tithi: chennai.chennaiTithiCorrectionsCenter,
      amavasya: chennai_b.chennaiAmavasyaCorrectionsCenter,
      purnima: chennai_b.chennaiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Chicago',
      tithi: chicago.chicagoTithiCorrectionsCenter,
      amavasya: chicago_b.chicagoAmavasyaCorrectionsCenter,
      purnima: chicago_b.chicagoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Coimbatore',
      tithi: coimbatore.coimbatoreTithiCorrectionsCenter,
      amavasya: coimbatore_b.coimbatoreAmavasyaCorrectionsCenter,
      purnima: coimbatore_b.coimbatorePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Colombo',
      tithi: colombo.colomboTithiCorrectionsCenter,
      amavasya: colombo_b.colomboAmavasyaCorrectionsCenter,
      purnima: colombo_b.colomboPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Columbus',
      tithi: columbus.columbusTithiCorrectionsCenter,
      amavasya: columbus_b.columbusAmavasyaCorrectionsCenter,
      purnima: columbus_b.columbusPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Copenhagen',
      tithi: copenhagen.copenhagenTithiCorrectionsCenter,
      amavasya: copenhagen_b.copenhagenAmavasyaCorrectionsCenter,
      purnima: copenhagen_b.copenhagenPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dallas',
      tithi: dallas.dallasTithiCorrectionsCenter,
      amavasya: dallas_b.dallasAmavasyaCorrectionsCenter,
      purnima: dallas_b.dallasPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dar es Salaam',
      tithi: daressalaam.daressalaamTithiCorrectionsCenter,
      amavasya: daressalaam_b.daressalaamAmavasyaCorrectionsCenter,
      purnima: daressalaam_b.daressalaamPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dehradun',
      tithi: dehradun.dehradunTithiCorrectionsCenter,
      amavasya: dehradun_b.dehradunAmavasyaCorrectionsCenter,
      purnima: dehradun_b.dehradunPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Delhi',
      tithi: delhi.delhiTithiCorrectionsCenter,
      amavasya: delhi_b.delhiAmavasyaCorrectionsCenter,
      purnima: delhi_b.delhiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Denpasar',
      tithi: denpasar.denpasarTithiCorrectionsCenter,
      amavasya: denpasar_b.denpasarAmavasyaCorrectionsCenter,
      purnima: denpasar_b.denpasarPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Denver',
      tithi: denver.denverTithiCorrectionsCenter,
      amavasya: denver_b.denverAmavasyaCorrectionsCenter,
      purnima: denver_b.denverPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Detroit',
      tithi: detroit.detroitTithiCorrectionsCenter,
      amavasya: detroit_b.detroitAmavasyaCorrectionsCenter,
      purnima: detroit_b.detroitPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dhaka',
      tithi: dhaka.dhakaTithiCorrectionsCenter,
      amavasya: dhaka_b.dhakaAmavasyaCorrectionsCenter,
      purnima: dhaka_b.dhakaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Doha',
      tithi: doha.dohaTithiCorrectionsCenter,
      amavasya: doha_b.dohaAmavasyaCorrectionsCenter,
      purnima: doha_b.dohaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dubai',
      tithi: dubai.dubaiTithiCorrectionsCenter,
      amavasya: dubai_b.dubaiAmavasyaCorrectionsCenter,
      purnima: dubai_b.dubaiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dublin',
      tithi: dublin.dublinTithiCorrectionsCenter,
      amavasya: dublin_b.dublinAmavasyaCorrectionsCenter,
      purnima: dublin_b.dublinPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Durban',
      tithi: durban.durbanTithiCorrectionsCenter,
      amavasya: durban_b.durbanAmavasyaCorrectionsCenter,
      purnima: durban_b.durbanPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Dwarka',
      tithi: dwarka.dwarkaTithiCorrectionsCenter,
      amavasya: dwarka_b.dwarkaAmavasyaCorrectionsCenter,
      purnima: dwarka_b.dwarkaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Edinburgh',
      tithi: edinburgh.edinburghTithiCorrectionsCenter,
      amavasya: edinburgh_b.edinburghAmavasyaCorrectionsCenter,
      purnima: edinburgh_b.edinburghPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Edmonton',
      tithi: edmonton.edmontonTithiCorrectionsCenter,
      amavasya: edmonton_b.edmontonAmavasyaCorrectionsCenter,
      purnima: edmonton_b.edmontonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Faridabad',
      tithi: faridabad.faridabadTithiCorrectionsCenter,
      amavasya: faridabad_b.faridabadAmavasyaCorrectionsCenter,
      purnima: faridabad_b.faridabadPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Fremont',
      tithi: fremont.fremontTithiCorrectionsCenter,
      amavasya: fremont_b.fremontAmavasyaCorrectionsCenter,
      purnima: fremont_b.fremontPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Georgetown',
      tithi: georgetown.georgetownTithiCorrectionsCenter,
      amavasya: georgetown_b.georgetownAmavasyaCorrectionsCenter,
      purnima: georgetown_b.georgetownPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ghaziabad',
      tithi: ghaziabad.ghaziabadTithiCorrectionsCenter,
      amavasya: ghaziabad_b.ghaziabadAmavasyaCorrectionsCenter,
      purnima: ghaziabad_b.ghaziabadPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Glasgow',
      tithi: glasgow.glasgowTithiCorrectionsCenter,
      amavasya: glasgow_b.glasgowAmavasyaCorrectionsCenter,
      purnima: glasgow_b.glasgowPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gorakhpur',
      tithi: gorakhpur.gorakhpurTithiCorrectionsCenter,
      amavasya: gorakhpur_b.gorakhpurAmavasyaCorrectionsCenter,
      purnima: gorakhpur_b.gorakhpurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gothenburg',
      tithi: gothenburg.gothenburgTithiCorrectionsCenter,
      amavasya: gothenburg_b.gothenburgAmavasyaCorrectionsCenter,
      purnima: gothenburg_b.gothenburgPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gurgaon',
      tithi: gurgaon.gurgaonTithiCorrectionsCenter,
      amavasya: gurgaon_b.gurgaonAmavasyaCorrectionsCenter,
      purnima: gurgaon_b.gurgaonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Guwahati',
      tithi: guwahati.guwahatiTithiCorrectionsCenter,
      amavasya: guwahati_b.guwahatiAmavasyaCorrectionsCenter,
      purnima: guwahati_b.guwahatiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Gwalior',
      tithi: gwalior.gwaliorTithiCorrectionsCenter,
      amavasya: gwalior_b.gwaliorAmavasyaCorrectionsCenter,
      purnima: gwalior_b.gwaliorPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Halifax',
      tithi: halifax.halifaxTithiCorrectionsCenter,
      amavasya: halifax_b.halifaxAmavasyaCorrectionsCenter,
      purnima: halifax_b.halifaxPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hanoi',
      tithi: hanoi.hanoiTithiCorrectionsCenter,
      amavasya: hanoi_b.hanoiAmavasyaCorrectionsCenter,
      purnima: hanoi_b.hanoiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Haridwar',
      tithi: haridwar.haridwarTithiCorrectionsCenter,
      amavasya: haridwar_b.haridwarAmavasyaCorrectionsCenter,
      purnima: haridwar_b.haridwarPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Helsinki',
      tithi: helsinki.helsinkiTithiCorrectionsCenter,
      amavasya: helsinki_b.helsinkiAmavasyaCorrectionsCenter,
      purnima: helsinki_b.helsinkiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ho Chi Minh City',
      tithi: hochiminhcity.hochiminhcityTithiCorrectionsCenter,
      amavasya: hochiminhcity_b.hochiminhcityAmavasyaCorrectionsCenter,
      purnima: hochiminhcity_b.hochiminhcityPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hong Kong',
      tithi: hongkong.hongkongTithiCorrectionsCenter,
      amavasya: hongkong_b.hongkongAmavasyaCorrectionsCenter,
      purnima: hongkong_b.hongkongPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Honolulu',
      tithi: honolulu.honoluluTithiCorrectionsCenter,
      amavasya: honolulu_b.honoluluAmavasyaCorrectionsCenter,
      purnima: honolulu_b.honoluluPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Houston',
      tithi: houston.houstonTithiCorrectionsCenter,
      amavasya: houston_b.houstonAmavasyaCorrectionsCenter,
      purnima: houston_b.houstonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hubli',
      tithi: hubli.hubliTithiCorrectionsCenter,
      amavasya: hubli_b.hubliAmavasyaCorrectionsCenter,
      purnima: hubli_b.hubliPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Hyderabad',
      tithi: hyderabad.hyderabadTithiCorrectionsCenter,
      amavasya: hyderabad_b.hyderabadAmavasyaCorrectionsCenter,
      purnima: hyderabad_b.hyderabadPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Indianapolis',
      tithi: indianapolis.indianapolisTithiCorrectionsCenter,
      amavasya: indianapolis_b.indianapolisAmavasyaCorrectionsCenter,
      purnima: indianapolis_b.indianapolisPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Indore',
      tithi: indore.indoreTithiCorrectionsCenter,
      amavasya: indore_b.indoreAmavasyaCorrectionsCenter,
      purnima: indore_b.indorePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Islamabad',
      tithi: islamabad.islamabadTithiCorrectionsCenter,
      amavasya: islamabad_b.islamabadAmavasyaCorrectionsCenter,
      purnima: islamabad_b.islamabadPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Istanbul',
      tithi: istanbul.istanbulTithiCorrectionsCenter,
      amavasya: istanbul_b.istanbulAmavasyaCorrectionsCenter,
      purnima: istanbul_b.istanbulPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jabalpur',
      tithi: jabalpur.jabalpurTithiCorrectionsCenter,
      amavasya: jabalpur_b.jabalpurAmavasyaCorrectionsCenter,
      purnima: jabalpur_b.jabalpurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jaipur',
      tithi: jaipur.jaipurTithiCorrectionsCenter,
      amavasya: jaipur_b.jaipurAmavasyaCorrectionsCenter,
      purnima: jaipur_b.jaipurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jakarta',
      tithi: jakarta.jakartaTithiCorrectionsCenter,
      amavasya: jakarta_b.jakartaAmavasyaCorrectionsCenter,
      purnima: jakarta_b.jakartaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jalandhar',
      tithi: jalandhar.jalandharTithiCorrectionsCenter,
      amavasya: jalandhar_b.jalandharAmavasyaCorrectionsCenter,
      purnima: jalandhar_b.jalandharPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jammu',
      tithi: jammu.jammuTithiCorrectionsCenter,
      amavasya: jammu_b.jammuAmavasyaCorrectionsCenter,
      purnima: jammu_b.jammuPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jeddah',
      tithi: jeddah.jeddahTithiCorrectionsCenter,
      amavasya: jeddah_b.jeddahAmavasyaCorrectionsCenter,
      purnima: jeddah_b.jeddahPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Jodhpur',
      tithi: jodhpur.jodhpurTithiCorrectionsCenter,
      amavasya: jodhpur_b.jodhpurAmavasyaCorrectionsCenter,
      purnima: jodhpur_b.jodhpurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Johannesburg',
      tithi: johannesburg.johannesburgTithiCorrectionsCenter,
      amavasya: johannesburg_b.johannesburgAmavasyaCorrectionsCenter,
      purnima: johannesburg_b.johannesburgPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kampala',
      tithi: kampala.kampalaTithiCorrectionsCenter,
      amavasya: kampala_b.kampalaAmavasyaCorrectionsCenter,
      purnima: kampala_b.kampalaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kanpur',
      tithi: kanpur.kanpurTithiCorrectionsCenter,
      amavasya: kanpur_b.kanpurAmavasyaCorrectionsCenter,
      purnima: kanpur_b.kanpurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kansas City',
      tithi: kansascity.kansascityTithiCorrectionsCenter,
      amavasya: kansascity_b.kansascityAmavasyaCorrectionsCenter,
      purnima: kansascity_b.kansascityPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Karachi',
      tithi: karachi.karachiTithiCorrectionsCenter,
      amavasya: karachi_b.karachiAmavasyaCorrectionsCenter,
      purnima: karachi_b.karachiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kathmandu',
      tithi: kathmandu.kathmanduTithiCorrectionsCenter,
      amavasya: kathmandu_b.kathmanduAmavasyaCorrectionsCenter,
      purnima: kathmandu_b.kathmanduPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kingston',
      tithi: kingston.kingstonTithiCorrectionsCenter,
      amavasya: kingston_b.kingstonAmavasyaCorrectionsCenter,
      purnima: kingston_b.kingstonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kirkland',
      tithi: kirkland.kirklandTithiCorrectionsCenter,
      amavasya: kirkland_b.kirklandAmavasyaCorrectionsCenter,
      purnima: kirkland_b.kirklandPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kochi',
      tithi: kochi.kochiTithiCorrectionsCenter,
      amavasya: kochi_b.kochiAmavasyaCorrectionsCenter,
      purnima: kochi_b.kochiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kolkata',
      tithi: kolkata.kolkataTithiCorrectionsCenter,
      amavasya: kolkata_b.kolkataAmavasyaCorrectionsCenter,
      purnima: kolkata_b.kolkataPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kota',
      tithi: kota.kotaTithiCorrectionsCenter,
      amavasya: kota_b.kotaAmavasyaCorrectionsCenter,
      purnima: kota_b.kotaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Krakow',
      tithi: krakow.krakowTithiCorrectionsCenter,
      amavasya: krakow_b.krakowAmavasyaCorrectionsCenter,
      purnima: krakow_b.krakowPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kuala Lumpur',
      tithi: kualalumpur.kualalumpurTithiCorrectionsCenter,
      amavasya: kualalumpur_b.kualalumpurAmavasyaCorrectionsCenter,
      purnima: kualalumpur_b.kualalumpurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kuwait City',
      tithi: kuwaitcity.kuwaitcityTithiCorrectionsCenter,
      amavasya: kuwaitcity_b.kuwaitcityAmavasyaCorrectionsCenter,
      purnima: kuwaitcity_b.kuwaitcityPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Kyiv',
      tithi: kyiv.kyivTithiCorrectionsCenter,
      amavasya: kyiv_b.kyivAmavasyaCorrectionsCenter,
      purnima: kyiv_b.kyivPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lagos',
      tithi: lagos.lagosTithiCorrectionsCenter,
      amavasya: lagos_b.lagosAmavasyaCorrectionsCenter,
      purnima: lagos_b.lagosPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lahore',
      tithi: lahore.lahoreTithiCorrectionsCenter,
      amavasya: lahore_b.lahoreAmavasyaCorrectionsCenter,
      purnima: lahore_b.lahorePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Las Vegas',
      tithi: lasvegas.lasvegasTithiCorrectionsCenter,
      amavasya: lasvegas_b.lasvegasAmavasyaCorrectionsCenter,
      purnima: lasvegas_b.lasvegasPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Leicester',
      tithi: leicester.leicesterTithiCorrectionsCenter,
      amavasya: leicester_b.leicesterAmavasyaCorrectionsCenter,
      purnima: leicester_b.leicesterPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lima',
      tithi: lima.limaTithiCorrectionsCenter,
      amavasya: lima_b.limaAmavasyaCorrectionsCenter,
      purnima: lima_b.limaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lisbon',
      tithi: lisbon.lisbonTithiCorrectionsCenter,
      amavasya: lisbon_b.lisbonAmavasyaCorrectionsCenter,
      purnima: lisbon_b.lisbonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('London',
      tithi: london.londonTithiCorrectionsCenter,
      amavasya: london_b.londonAmavasyaCorrectionsCenter,
      purnima: london_b.londonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Los Angeles',
      tithi: losangeles.losangelesTithiCorrectionsCenter,
      amavasya: losangeles_b.losangelesAmavasyaCorrectionsCenter,
      purnima: losangeles_b.losangelesPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lucknow',
      tithi: lucknow.lucknowTithiCorrectionsCenter,
      amavasya: lucknow_b.lucknowAmavasyaCorrectionsCenter,
      purnima: lucknow_b.lucknowPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ludhiana',
      tithi: ludhiana.ludhianaTithiCorrectionsCenter,
      amavasya: ludhiana_b.ludhianaAmavasyaCorrectionsCenter,
      purnima: ludhiana_b.ludhianaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Lyon',
      tithi: lyon.lyonTithiCorrectionsCenter,
      amavasya: lyon_b.lyonAmavasyaCorrectionsCenter,
      purnima: lyon_b.lyonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Madrid',
      tithi: madrid.madridTithiCorrectionsCenter,
      amavasya: madrid_b.madridAmavasyaCorrectionsCenter,
      purnima: madrid_b.madridPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Madurai',
      tithi: madurai.maduraiTithiCorrectionsCenter,
      amavasya: madurai_b.maduraiAmavasyaCorrectionsCenter,
      purnima: madurai_b.maduraiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Manchester',
      tithi: manchester.manchesterTithiCorrectionsCenter,
      amavasya: manchester_b.manchesterAmavasyaCorrectionsCenter,
      purnima: manchester_b.manchesterPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mangalore',
      tithi: mangalore.mangaloreTithiCorrectionsCenter,
      amavasya: mangalore_b.mangaloreAmavasyaCorrectionsCenter,
      purnima: mangalore_b.mangalorePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Manila',
      tithi: manila.manilaTithiCorrectionsCenter,
      amavasya: manila_b.manilaAmavasyaCorrectionsCenter,
      purnima: manila_b.manilaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mathura',
      tithi: mathura.mathuraTithiCorrectionsCenter,
      amavasya: mathura_b.mathuraAmavasyaCorrectionsCenter,
      purnima: mathura_b.mathuraPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Medellín',
      tithi: medellin.medellinTithiCorrectionsCenter,
      amavasya: medellin_b.medellinAmavasyaCorrectionsCenter,
      purnima: medellin_b.medellinPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Meerut',
      tithi: meerut.meerutTithiCorrectionsCenter,
      amavasya: meerut_b.meerutAmavasyaCorrectionsCenter,
      purnima: meerut_b.meerutPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Melbourne',
      tithi: melbourne.melbourneTithiCorrectionsCenter,
      amavasya: melbourne_b.melbourneAmavasyaCorrectionsCenter,
      purnima: melbourne_b.melbournePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mexico City',
      tithi: mexicocity.mexicocityTithiCorrectionsCenter,
      amavasya: mexicocity_b.mexicocityAmavasyaCorrectionsCenter,
      purnima: mexicocity_b.mexicocityPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Miami',
      tithi: miami.miamiTithiCorrectionsCenter,
      amavasya: miami_b.miamiAmavasyaCorrectionsCenter,
      purnima: miami_b.miamiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Milan',
      tithi: milan.milanTithiCorrectionsCenter,
      amavasya: milan_b.milanAmavasyaCorrectionsCenter,
      purnima: milan_b.milanPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Minneapolis',
      tithi: minneapolis.minneapolisTithiCorrectionsCenter,
      amavasya: minneapolis_b.minneapolisAmavasyaCorrectionsCenter,
      purnima: minneapolis_b.minneapolisPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mississauga',
      tithi: mississauga.mississaugaTithiCorrectionsCenter,
      amavasya: mississauga_b.mississaugaAmavasyaCorrectionsCenter,
      purnima: mississauga_b.mississaugaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mombasa',
      tithi: mombasa.mombasaTithiCorrectionsCenter,
      amavasya: mombasa_b.mombasaAmavasyaCorrectionsCenter,
      purnima: mombasa_b.mombasaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Montreal',
      tithi: montreal.montrealTithiCorrectionsCenter,
      amavasya: montreal_b.montrealAmavasyaCorrectionsCenter,
      purnima: montreal_b.montrealPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Moscow',
      tithi: moscow.moscowTithiCorrectionsCenter,
      amavasya: moscow_b.moscowAmavasyaCorrectionsCenter,
      purnima: moscow_b.moscowPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mumbai',
      tithi: mumbai.mumbaiTithiCorrectionsCenter,
      amavasya: mumbai_b.mumbaiAmavasyaCorrectionsCenter,
      purnima: mumbai_b.mumbaiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Munich',
      tithi: munich.munichTithiCorrectionsCenter,
      amavasya: munich_b.munichAmavasyaCorrectionsCenter,
      purnima: munich_b.munichPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Muscat',
      tithi: muscat.muscatTithiCorrectionsCenter,
      amavasya: muscat_b.muscatAmavasyaCorrectionsCenter,
      purnima: muscat_b.muscatPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mussoorie',
      tithi: mussoorie.mussoorieTithiCorrectionsCenter,
      amavasya: mussoorie_b.mussoorieAmavasyaCorrectionsCenter,
      purnima: mussoorie_b.mussooriePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Mysore',
      tithi: mysore.mysoreTithiCorrectionsCenter,
      amavasya: mysore_b.mysoreAmavasyaCorrectionsCenter,
      purnima: mysore_b.mysorePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nagpur',
      tithi: nagpur.nagpurTithiCorrectionsCenter,
      amavasya: nagpur_b.nagpurAmavasyaCorrectionsCenter,
      purnima: nagpur_b.nagpurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nairobi',
      tithi: nairobi.nairobiTithiCorrectionsCenter,
      amavasya: nairobi_b.nairobiAmavasyaCorrectionsCenter,
      purnima: nairobi_b.nairobiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Naples',
      tithi: naples.naplesTithiCorrectionsCenter,
      amavasya: naples_b.naplesAmavasyaCorrectionsCenter,
      purnima: naples_b.naplesPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nashik',
      tithi: nashik.nashikTithiCorrectionsCenter,
      amavasya: nashik_b.nashikAmavasyaCorrectionsCenter,
      purnima: nashik_b.nashikPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Nashville',
      tithi: nashville.nashvilleTithiCorrectionsCenter,
      amavasya: nashville_b.nashvilleAmavasyaCorrectionsCenter,
      purnima: nashville_b.nashvillePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('New York',
      tithi: newyork.newyorkTithiCorrectionsCenter,
      amavasya: newyork_b.newyorkAmavasyaCorrectionsCenter,
      purnima: newyork_b.newyorkPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Noida',
      tithi: noida.noidaTithiCorrectionsCenter,
      amavasya: noida_b.noidaAmavasyaCorrectionsCenter,
      purnima: noida_b.noidaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Orlando',
      tithi: orlando.orlandoTithiCorrectionsCenter,
      amavasya: orlando_b.orlandoAmavasyaCorrectionsCenter,
      purnima: orlando_b.orlandoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Osaka',
      tithi: osaka.osakaTithiCorrectionsCenter,
      amavasya: osaka_b.osakaAmavasyaCorrectionsCenter,
      purnima: osaka_b.osakaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Oslo',
      tithi: oslo.osloTithiCorrectionsCenter,
      amavasya: oslo_b.osloAmavasyaCorrectionsCenter,
      purnima: oslo_b.osloPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ottawa',
      tithi: ottawa.ottawaTithiCorrectionsCenter,
      amavasya: ottawa_b.ottawaAmavasyaCorrectionsCenter,
      purnima: ottawa_b.ottawaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Panama City',
      tithi: panamacity.panamacityTithiCorrectionsCenter,
      amavasya: panamacity_b.panamacityAmavasyaCorrectionsCenter,
      purnima: panamacity_b.panamacityPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Paramaribo',
      tithi: paramaribo.paramariboTithiCorrectionsCenter,
      amavasya: paramaribo_b.paramariboAmavasyaCorrectionsCenter,
      purnima: paramaribo_b.paramariboPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Paris',
      tithi: paris.parisTithiCorrectionsCenter,
      amavasya: paris_b.parisAmavasyaCorrectionsCenter,
      purnima: paris_b.parisPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Patna',
      tithi: patna.patnaTithiCorrectionsCenter,
      amavasya: patna_b.patnaAmavasyaCorrectionsCenter,
      purnima: patna_b.patnaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Perth',
      tithi: perth.perthTithiCorrectionsCenter,
      amavasya: perth_b.perthAmavasyaCorrectionsCenter,
      purnima: perth_b.perthPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Philadelphia',
      tithi: philadelphia.philadelphiaTithiCorrectionsCenter,
      amavasya: philadelphia_b.philadelphiaAmavasyaCorrectionsCenter,
      purnima: philadelphia_b.philadelphiaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Phnom Penh',
      tithi: phnompenh.phnompenhTithiCorrectionsCenter,
      amavasya: phnompenh_b.phnompenhAmavasyaCorrectionsCenter,
      purnima: phnompenh_b.phnompenhPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Phoenix',
      tithi: phoenix.phoenixTithiCorrectionsCenter,
      amavasya: phoenix_b.phoenixAmavasyaCorrectionsCenter,
      purnima: phoenix_b.phoenixPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Pittsburgh',
      tithi: pittsburgh.pittsburghTithiCorrectionsCenter,
      amavasya: pittsburgh_b.pittsburghAmavasyaCorrectionsCenter,
      purnima: pittsburgh_b.pittsburghPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Portland',
      tithi: portland.portlandTithiCorrectionsCenter,
      amavasya: portland_b.portlandAmavasyaCorrectionsCenter,
      purnima: portland_b.portlandPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Port Louis',
      tithi: portlouis.portlouisTithiCorrectionsCenter,
      amavasya: portlouis_b.portlouisAmavasyaCorrectionsCenter,
      purnima: portlouis_b.portlouisPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Porto',
      tithi: porto.portoTithiCorrectionsCenter,
      amavasya: porto_b.portoAmavasyaCorrectionsCenter,
      purnima: porto_b.portoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Port of Spain',
      tithi: portofspain.portofspainTithiCorrectionsCenter,
      amavasya: portofspain_b.portofspainAmavasyaCorrectionsCenter,
      purnima: portofspain_b.portofspainPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Prague',
      tithi: prague.pragueTithiCorrectionsCenter,
      amavasya: prague_b.pragueAmavasyaCorrectionsCenter,
      purnima: prague_b.praguePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Prayagraj',
      tithi: prayagraj.prayagrajTithiCorrectionsCenter,
      amavasya: prayagraj_b.prayagrajAmavasyaCorrectionsCenter,
      purnima: prayagraj_b.prayagrajPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Pune',
      tithi: pune.puneTithiCorrectionsCenter,
      amavasya: pune_b.puneAmavasyaCorrectionsCenter,
      purnima: pune_b.punePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Quito',
      tithi: quito.quitoTithiCorrectionsCenter,
      amavasya: quito_b.quitoAmavasyaCorrectionsCenter,
      purnima: quito_b.quitoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Raipur',
      tithi: raipur.raipurTithiCorrectionsCenter,
      amavasya: raipur_b.raipurAmavasyaCorrectionsCenter,
      purnima: raipur_b.raipurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rajkot',
      tithi: rajkot.rajkotTithiCorrectionsCenter,
      amavasya: rajkot_b.rajkotAmavasyaCorrectionsCenter,
      purnima: rajkot_b.rajkotPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Raleigh',
      tithi: raleigh.raleighTithiCorrectionsCenter,
      amavasya: raleigh_b.raleighAmavasyaCorrectionsCenter,
      purnima: raleigh_b.raleighPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ranchi',
      tithi: ranchi.ranchiTithiCorrectionsCenter,
      amavasya: ranchi_b.ranchiAmavasyaCorrectionsCenter,
      purnima: ranchi_b.ranchiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Redmond',
      tithi: redmond.redmondTithiCorrectionsCenter,
      amavasya: redmond_b.redmondAmavasyaCorrectionsCenter,
      purnima: redmond_b.redmondPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Regina',
      tithi: regina.reginaTithiCorrectionsCenter,
      amavasya: regina_b.reginaAmavasyaCorrectionsCenter,
      purnima: regina_b.reginaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rio de Janeiro',
      tithi: riodejaneiro.riodejaneiroTithiCorrectionsCenter,
      amavasya: riodejaneiro_b.riodejaneiroAmavasyaCorrectionsCenter,
      purnima: riodejaneiro_b.riodejaneiroPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rishikesh',
      tithi: rishikesh.rishikeshTithiCorrectionsCenter,
      amavasya: rishikesh_b.rishikeshAmavasyaCorrectionsCenter,
      purnima: rishikesh_b.rishikeshPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Riyadh',
      tithi: riyadh.riyadhTithiCorrectionsCenter,
      amavasya: riyadh_b.riyadhAmavasyaCorrectionsCenter,
      purnima: riyadh_b.riyadhPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rome',
      tithi: rome.romeTithiCorrectionsCenter,
      amavasya: rome_b.romeAmavasyaCorrectionsCenter,
      purnima: rome_b.romePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Rotterdam',
      tithi: rotterdam.rotterdamTithiCorrectionsCenter,
      amavasya: rotterdam_b.rotterdamAmavasyaCorrectionsCenter,
      purnima: rotterdam_b.rotterdamPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Sacramento',
      tithi: sacramento.sacramentoTithiCorrectionsCenter,
      amavasya: sacramento_b.sacramentoAmavasyaCorrectionsCenter,
      purnima: sacramento_b.sacramentoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Salem',
      tithi: salem.salemTithiCorrectionsCenter,
      amavasya: salem_b.salemAmavasyaCorrectionsCenter,
      purnima: salem_b.salemPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Salt Lake City',
      tithi: saltlakecity.saltlakecityTithiCorrectionsCenter,
      amavasya: saltlakecity_b.saltlakecityAmavasyaCorrectionsCenter,
      purnima: saltlakecity_b.saltlakecityPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('San Diego',
      tithi: sandiego.sandiegoTithiCorrectionsCenter,
      amavasya: sandiego_b.sandiegoAmavasyaCorrectionsCenter,
      purnima: sandiego_b.sandiegoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('San Francisco',
      tithi: sanfrancisco.sanfranciscoTithiCorrectionsCenter,
      amavasya: sanfrancisco_b.sanfranciscoAmavasyaCorrectionsCenter,
      purnima: sanfrancisco_b.sanfranciscoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('San Jose',
      tithi: sanjose.sanjoseTithiCorrectionsCenter,
      amavasya: sanjose_b.sanjoseAmavasyaCorrectionsCenter,
      purnima: sanjose_b.sanjosePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Santiago',
      tithi: santiago.santiagoTithiCorrectionsCenter,
      amavasya: santiago_b.santiagoAmavasyaCorrectionsCenter,
      purnima: santiago_b.santiagoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Seattle',
      tithi: seattle.seattleTithiCorrectionsCenter,
      amavasya: seattle_b.seattleAmavasyaCorrectionsCenter,
      purnima: seattle_b.seattlePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Seoul',
      tithi: seoul.seoulTithiCorrectionsCenter,
      amavasya: seoul_b.seoulAmavasyaCorrectionsCenter,
      purnima: seoul_b.seoulPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Shanghai',
      tithi: shanghai.shanghaiTithiCorrectionsCenter,
      amavasya: shanghai_b.shanghaiAmavasyaCorrectionsCenter,
      purnima: shanghai_b.shanghaiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Shirdi',
      tithi: shirdi.shirdiTithiCorrectionsCenter,
      amavasya: shirdi_b.shirdiAmavasyaCorrectionsCenter,
      purnima: shirdi_b.shirdiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Singapore',
      tithi: singapore.singaporeTithiCorrectionsCenter,
      amavasya: singapore_b.singaporeAmavasyaCorrectionsCenter,
      purnima: singapore_b.singaporePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Sofia',
      tithi: sofia.sofiaTithiCorrectionsCenter,
      amavasya: sofia_b.sofiaAmavasyaCorrectionsCenter,
      purnima: sofia_b.sofiaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('São Paulo',
      tithi: sopaulo.sopauloTithiCorrectionsCenter,
      amavasya: sopaulo_b.sopauloAmavasyaCorrectionsCenter,
      purnima: sopaulo_b.sopauloPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Srinagar',
      tithi: srinagar.srinagarTithiCorrectionsCenter,
      amavasya: srinagar_b.srinagarAmavasyaCorrectionsCenter,
      purnima: srinagar_b.srinagarPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('St. Louis',
      tithi: stlouis.stlouisTithiCorrectionsCenter,
      amavasya: stlouis_b.stlouisAmavasyaCorrectionsCenter,
      purnima: stlouis_b.stlouisPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Stockholm',
      tithi: stockholm.stockholmTithiCorrectionsCenter,
      amavasya: stockholm_b.stockholmAmavasyaCorrectionsCenter,
      purnima: stockholm_b.stockholmPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Surat',
      tithi: surat.suratTithiCorrectionsCenter,
      amavasya: surat_b.suratAmavasyaCorrectionsCenter,
      purnima: surat_b.suratPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Surrey',
      tithi: surrey.surreyTithiCorrectionsCenter,
      amavasya: surrey_b.surreyAmavasyaCorrectionsCenter,
      purnima: surrey_b.surreyPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Suva',
      tithi: suva.suvaTithiCorrectionsCenter,
      amavasya: suva_b.suvaAmavasyaCorrectionsCenter,
      purnima: suva_b.suvaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Sydney',
      tithi: sydney.sydneyTithiCorrectionsCenter,
      amavasya: sydney_b.sydneyAmavasyaCorrectionsCenter,
      purnima: sydney_b.sydneyPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Taipei',
      tithi: taipei.taipeiTithiCorrectionsCenter,
      amavasya: taipei_b.taipeiAmavasyaCorrectionsCenter,
      purnima: taipei_b.taipeiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tampa',
      tithi: tampa.tampaTithiCorrectionsCenter,
      amavasya: tampa_b.tampaAmavasyaCorrectionsCenter,
      purnima: tampa_b.tampaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tashkent',
      tithi: tashkent.tashkentTithiCorrectionsCenter,
      amavasya: tashkent_b.tashkentAmavasyaCorrectionsCenter,
      purnima: tashkent_b.tashkentPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tel Aviv',
      tithi: telaviv.telavivTithiCorrectionsCenter,
      amavasya: telaviv_b.telavivAmavasyaCorrectionsCenter,
      purnima: telaviv_b.telavivPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Thane',
      tithi: thane.thaneTithiCorrectionsCenter,
      amavasya: thane_b.thaneAmavasyaCorrectionsCenter,
      purnima: thane_b.thanePurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Thessaloniki',
      tithi: thessaloniki.thessalonikiTithiCorrectionsCenter,
      amavasya: thessaloniki_b.thessalonikiAmavasyaCorrectionsCenter,
      purnima: thessaloniki_b.thessalonikiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Thiruvananthapuram',
      tithi: thiruvananthapuram.thiruvananthapuramTithiCorrectionsCenter,
      amavasya:
          thiruvananthapuram_b.thiruvananthapuramAmavasyaCorrectionsCenter,
      purnima: thiruvananthapuram_b.thiruvananthapuramPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tiruchirappalli',
      tithi: tiruchirappalli.tiruchirappalliTithiCorrectionsCenter,
      amavasya: tiruchirappalli_b.tiruchirappalliAmavasyaCorrectionsCenter,
      purnima: tiruchirappalli_b.tiruchirappalliPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tirupati',
      tithi: tirupati.tirupatiTithiCorrectionsCenter,
      amavasya: tirupati_b.tirupatiAmavasyaCorrectionsCenter,
      purnima: tirupati_b.tirupatiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Tokyo',
      tithi: tokyo.tokyoTithiCorrectionsCenter,
      amavasya: tokyo_b.tokyoAmavasyaCorrectionsCenter,
      purnima: tokyo_b.tokyoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Toronto',
      tithi: toronto.torontoTithiCorrectionsCenter,
      amavasya: toronto_b.torontoAmavasyaCorrectionsCenter,
      purnima: toronto_b.torontoPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Udaipur',
      tithi: udaipur.udaipurTithiCorrectionsCenter,
      amavasya: udaipur_b.udaipurAmavasyaCorrectionsCenter,
      purnima: udaipur_b.udaipurPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Ujjain',
      tithi: ujjain.ujjainTithiCorrectionsCenter,
      amavasya: ujjain_b.ujjainAmavasyaCorrectionsCenter,
      purnima: ujjain_b.ujjainPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vadodara',
      tithi: vadodara.vadodaraTithiCorrectionsCenter,
      amavasya: vadodara_b.vadodaraAmavasyaCorrectionsCenter,
      purnima: vadodara_b.vadodaraPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vancouver',
      tithi: vancouver.vancouverTithiCorrectionsCenter,
      amavasya: vancouver_b.vancouverAmavasyaCorrectionsCenter,
      purnima: vancouver_b.vancouverPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Varanasi',
      tithi: varanasi.varanasiTithiCorrectionsCenter,
      amavasya: varanasi_b.varanasiAmavasyaCorrectionsCenter,
      purnima: varanasi_b.varanasiPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vienna',
      tithi: vienna.viennaTithiCorrectionsCenter,
      amavasya: vienna_b.viennaAmavasyaCorrectionsCenter,
      purnima: vienna_b.viennaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vijayawada',
      tithi: vijayawada.vijayawadaTithiCorrectionsCenter,
      amavasya: vijayawada_b.vijayawadaAmavasyaCorrectionsCenter,
      purnima: vijayawada_b.vijayawadaPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Visakhapatnam',
      tithi: visakhapatnam.visakhapatnamTithiCorrectionsCenter,
      amavasya: visakhapatnam_b.visakhapatnamAmavasyaCorrectionsCenter,
      purnima: visakhapatnam_b.visakhapatnamPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Vrindavan',
      tithi: vrindavan.vrindavanTithiCorrectionsCenter,
      amavasya: vrindavan_b.vrindavanAmavasyaCorrectionsCenter,
      purnima: vrindavan_b.vrindavanPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Warangal',
      tithi: warangal.warangalTithiCorrectionsCenter,
      amavasya: warangal_b.warangalAmavasyaCorrectionsCenter,
      purnima: warangal_b.warangalPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Warsaw',
      tithi: warsaw.warsawTithiCorrectionsCenter,
      amavasya: warsaw_b.warsawAmavasyaCorrectionsCenter,
      purnima: warsaw_b.warsawPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Washington DC',
      tithi: washingtondc.washingtondcTithiCorrectionsCenter,
      amavasya: washingtondc_b.washingtondcAmavasyaCorrectionsCenter,
      purnima: washingtondc_b.washingtondcPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Wellington',
      tithi: wellington.wellingtonTithiCorrectionsCenter,
      amavasya: wellington_b.wellingtonAmavasyaCorrectionsCenter,
      purnima: wellington_b.wellingtonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Winnipeg',
      tithi: winnipeg.winnipegTithiCorrectionsCenter,
      amavasya: winnipeg_b.winnipegAmavasyaCorrectionsCenter,
      purnima: winnipeg_b.winnipegPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Yangon',
      tithi: yangon.yangonTithiCorrectionsCenter,
      amavasya: yangon_b.yangonAmavasyaCorrectionsCenter,
      purnima: yangon_b.yangonPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Zagreb',
      tithi: zagreb.zagrebTithiCorrectionsCenter,
      amavasya: zagreb_b.zagrebAmavasyaCorrectionsCenter,
      purnima: zagreb_b.zagrebPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
  registerCity('Zurich',
      tithi: zurich.zurichTithiCorrectionsCenter,
      amavasya: zurich_b.zurichAmavasyaCorrectionsCenter,
      purnima: zurich_b.zurichPurnimaCorrectionsCenter,
      convention: SunriseConvention.centerDisc);
}
