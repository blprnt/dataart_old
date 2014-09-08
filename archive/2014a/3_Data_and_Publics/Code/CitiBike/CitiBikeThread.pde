public class CitiBikeThread extends Thread {

  private boolean running;           // Is the thread running?  Yes or no?
  String id;                         // id, to keep our threads identifiable.

  // Constructor, create the thread
  // It is not running by default
  public CitiBikeThread (String _id) {
    id = _id;
  }

  // Overriding "start()"
  public void start () {
    // Set running equal to true
    running = true;
    // Print messages
    super.start();
  }

  // We must implement run, this gets triggered by start()
  public void run () 
  {
    System.out.println("Thread stuff is happening! It's happening!");  // The thread is done when we get to the end of run()
    loadStations();
    quit();
  }

  // Our method that quits the thread
  public void quit() {
    System.out.println("Quitting.");
    running = false;  // Setting running to false ends the loop in run()
    interrupt(); // in case the thread is waiting. . .
  }

  public void loadStations() {
    JSONObject stationJSON = loadJSONObject(endPoint);
    JSONArray stationList = stationJSON.getJSONArray("stationBeanList");
    for (int i = 0; i < stationList.size(); i++) {
      JSONObject sj = stationList.getJSONObject(i); 
      //println(sj.getString("stationName"));
      String id = str(sj.getInt("id"));
      //Have we already seen this station?
      if (stationMap.containsKey(id)) {
        //Previously seen station
        Station s = stationMap.get(id);
        s.updateDocks(sj.getInt("availableDocks"));
      } 
      else {
        //New station
        Station s = new Station();
        s.totalDocks = sj.getInt("totalDocks");
        s.availableDocks = sj.getInt("availableDocks");
        s.tpos = new PVector(map(i, 0, stationList.size(), 0, width), height/2);
        allStations.add(s);
        stationMap.put(id, s);
      }
    }
  }
}

