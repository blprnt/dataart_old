
void addNamesAndAgeAndDates(){
  Table data = loadTable("deadPeople2013DataMen.tsv", "header, tsv");
  data.addColumn("name");
  data.addColumn("age");
  data.addColumn("day of death");
  data.addColumn("month of death");
  data.addColumn("year of death");
  //data.addColumn("desc");
  
  String[] temp = new String[data.getRowCount()];
  for (int i = 0; i < data.getRowCount(); i++) {
    if(data.getRow(i).getString(2) == null) continue;
    String headline = data.getRow(i).getString(0);
    float age = ageFinder(headline);
    if(age == 0) continue;
   
    String[] tokens = split(headline, ",");
    String name = tokens[0];
    data.setString(i, 3, name);
    
    
    data.setFloat(i, 4, age);
    
    String date = data.getRow(i).getString(2);
    
    int day = getDay(date);
    int month = getMonth(date);
    int year = getYear(date);
    
    data.setInt(i, 5, day);
    data.setInt(i, 6, month);
    data.setInt(i, 7, year);
    //String desc = (tokens[1] != null)? tokens[1] : "";
    //data.setString(i, 8, desc);
    
    
  }
  
  saveTable(data, "data/deadPeople2013DataMenWithNamesAndAgeAndDatesWithDesc.tsv");
  
  
}
