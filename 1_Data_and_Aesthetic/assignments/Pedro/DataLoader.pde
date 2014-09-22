class DataLoader {
  Table myTable;
  int[] counts;

  //-------------------------------------------------------- Constructor
  DataLoader(String dataFile) {
    
    println("// Loading Data from " + dataFile);
    
    myTable = loadTable(dataFile);
    counts = new int[myTable.getRowCount()];
    for(int i=0; i<myTable.getRowCount(); i++){
      counts[i] = myTable.getRow(i).getInt(0);
      //println( counts[i] );
    }
    
    println("#1 Data Loaded");
  }
  
  //-------------------------------------------------------- Method to return Size
  int getSize() {
    return counts.length;
  }
  
  //-------------------------------------------------------- Method to return Value
  int getValue(int index) {
    return counts[index];
  }
  
  //-------------------------------------------------------- Method to return Max Value
  int getMax() {
    return max(counts);
  }
  
  //-------------------------------------------------------- Method to return Min Value
  int getMin() {
    return min(counts);
  }
  
  
  
 }
