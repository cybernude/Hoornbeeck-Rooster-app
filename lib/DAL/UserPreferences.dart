import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  SharedPreferences sharedPreferences;
  String FIRSTSTART = "FIRSTSTART";
String CLASSLIST = "CLASSLIST";

  _initializeUserPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> isFirstStart() async {
    await _initializeUserPreferences();
    bool result=true;
    try {
      result = sharedPreferences.getBool(FIRSTSTART);
      if(result==null)
        {
          sharedPreferences.setBool(FIRSTSTART, true);
        }
    } catch (Exception) {

    }
    return result ??true;
  }
  addClass(String classCode) async{
    await _initializeUserPreferences();
    try{
    List<String> list= sharedPreferences.getStringList(CLASSLIST);
    if(list!=null)
      {
        list.add(classCode);
        sharedPreferences.setStringList(CLASSLIST, list);
      }
      else{
      sharedPreferences.setStringList(CLASSLIST,[classCode]);

    }
    }
    catch(Exception){
      return "Er ging iets fout bij het opslaan van de geselecteerde waarde";
    }
  }
  removeClass(int index)async{
    await _initializeUserPreferences();
        try{
        List<String> list= sharedPreferences.getStringList(CLASSLIST);
        if(list!=null)
        {
        list.removeAt(index);
        sharedPreferences.setStringList(CLASSLIST, list);
        }
        }
        catch(Exception){
      return "Er ging iets fout bij verwijderen van een waarde";
    }
  }
  getClasses() async{
    await _initializeUserPreferences();
    try{
      List<String> list= sharedPreferences.getStringList(CLASSLIST);
      if(list!=null&&list.length>0)
      {
        return list;
      }
      else{
        return ["Fout","Geen roosters gevonden maak een nieuwe aan om er één te selecteren"];
      }
    }
    catch(Exception){
      return ["Fout","Er ging iets fout bij het ophalen van de roosters"];
    }
  }
}
