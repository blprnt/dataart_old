public class SimplestThread extends Thread {

  private boolean running;           // Is the thread running?  Yes or no?
  String id;                         // id, to keep our threads identifiable.

  // Constructor, create the thread
  // It is not running by default
  public SimplestThread (String _id) {
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
    quit();
  }

  // Our method that quits the thread
  public void quit() {
    System.out.println("Quitting.");
    running = false;  // Setting running to false ends the loop in run()
    interrupt(); // in case the thread is waiting. . .
  }
}
