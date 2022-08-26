import hudson.model.*
def requiredNodes = ['Slave4'];
def status = 0;
for (node in requiredNodes) 
{
slave = Hudson.instance.slaves.find({it.name == node});
      if (slave != null)
       {
       computer = slave.getComputer()
       println "$node found"
            if (computer.isOffline())
            {
               println "$node is offline.";
               status = 1;
            }
             else 
            {
            println "$node is online"; 
               computer.setTemporarilyOffline(true)    
               println "Now $node in offline"
            }
            for (aSlave in hudson.model.Hudson.instance.slaves)  {
                   if (aSlave.getComputer().isOffline()) 
                   {
                       aSlave.getComputer().setTemporarilyOffline(true);
                       aSlave.getComputer().doDoDelete();
                       println "$node is now deleted"
                   }
         }
       }
       else {
        println "$node does not exists."
       }
}


