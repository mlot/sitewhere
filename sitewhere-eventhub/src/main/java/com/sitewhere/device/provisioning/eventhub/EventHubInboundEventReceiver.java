package com.sitewhere.device.provisioning.eventhub;

import com.sitewhere.device.provisioning.eventhub.client.EventData;
import com.sitewhere.device.provisioning.eventhub.client.EventHubReceiverTask;
import com.sitewhere.device.provisioning.eventhub.client.EventHubReceiverTaskConfig;
import com.sitewhere.server.lifecycle.LifecycleComponent;
import com.sitewhere.spi.SiteWhereException;
import com.sitewhere.spi.device.provisioning.IInboundEventReceiver;
import com.sitewhere.spi.device.provisioning.IInboundEventSource;
import org.apache.log4j.Logger;
import org.apache.qpid.amqp_1_0.client.Message;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;


public class EventHubInboundEventReceiver extends LifecycleComponent implements IInboundEventReceiver<byte[]> {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(EventHubInboundEventReceiver.class);
    private static String username = "";
    private static String password = "";
    private static String namespace = "";
    private static String entityPath = "";
    private static int partitionCount = 0;
    private static String zkStateStore = "";
    private static String targetFqn = "";

    /**
     * Parent event source
     */
    private IInboundEventSource<byte[]> eventSource;

    private static EventHubReceiverTaskConfig config;

    private ExecutorService executor = Executors.newCachedThreadPool(new ReceiverThreadFactory());

    /**
     * Used for naming consumer threads
     */
    private class ReceiverThreadFactory implements ThreadFactory {

        /**
         * Counts threads
         */
        private AtomicInteger counter = new AtomicInteger();

        public Thread newThread(Runnable r) {
            return new Thread(r, "SiteWhere EventHub(" + namespace + " - " + entityPath
                    + ") Receiver " + counter.incrementAndGet());
        }
    }


    @Override
    public void start() throws SiteWhereException {
        config = new EventHubReceiverTaskConfig(username, password, namespace, entityPath,
                partitionCount, zkStateStore);
        config.setTargetAddress(targetFqn);

        for (int i = 0; i < partitionCount; i++) {
            executor.execute(new EventProcessor(partitionCount, i));
        }
    }

    @Override
    public void stop() throws SiteWhereException {
        for (int i = 0; i < partitionCount; i++) {
            executor.shutdownNow();
        }
    }

    @Override
    public Logger getLogger() {
        return logger;
    }

    private class EventProcessor implements Runnable {

        int taskIndex;
        int totalTasks;

        public EventProcessor(int totalTasks, int taskIndex) {
            this.totalTasks = totalTasks;
            this.taskIndex = taskIndex;
        }

        @Override
        public void run() {
            EventHubReceiverTask task = new EventHubReceiverTask(config);
            Map<String, Integer> context = new HashMap<String, Integer>();
            context.put("totalTasks", this.totalTasks);
            context.put("taskIndex", this.taskIndex);
            boolean SWITCH = true;

            while (SWITCH) {

                int EH_RETRY_SLEEP_SECONDS = 5;
                try {
                    task.open(context);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                    try {
                        task.close();
                        Thread.sleep(EH_RETRY_SLEEP_SECONDS * 1000);
                    } catch (Exception ignored) {
                    }
                    continue;
                }

                while (SWITCH) {
                    try {
                        EventData data = task.receive();
                        if (data == null) {
                            continue;
                        }
                        Message p = data.getMessage();

                        if (p == null || p.getApplicationProperties() == null ||
                                p.getApplicationProperties().getValue() == null ||
                                p.getApplicationProperties().getValue().get("payload") == null) {
                            continue;
                        }

                        getEventSource().onEncodedEventReceived(p.getApplicationProperties().getValue().get("payload").toString().getBytes());

                    } catch (Exception e) {
                        e.printStackTrace();
                        logger.warn("Exception in task " + taskIndex + ":" + e.getMessage() + " restarting...");
                        try {
                            task.close();
                        } catch (Exception e1) {
                            logger.error(e1.getMessage());
                        }
                        break;
                    } catch (Throwable t) {
                        logger.error("Error in task " + taskIndex + ":" + t.getMessage());
                        try {
                            task.close();
                        } catch (Throwable t1) {
                            logger.error(t1.getMessage());
                        }
                        SWITCH = false;
                    }
                }

                try {
                    Thread.sleep(EH_RETRY_SLEEP_SECONDS * 1000);
                } catch (InterruptedException e) {
                    //ignore
                }

            }

        }
    }

    public IInboundEventSource<byte[]> getEventSource() {
        return eventSource;
    }

    public void setEventSource(IInboundEventSource<byte[]> eventSource) {
        this.eventSource = eventSource;
    }


    public static void setUsername(String username) {
        EventHubInboundEventReceiver.username = username;
    }

    public static void setPassword(String password) {
        EventHubInboundEventReceiver.password = password;
    }

    public static void setNamespace(String namespace) {
        EventHubInboundEventReceiver.namespace = namespace;
    }

    public static void setEntityPath(String entityPath) {
        EventHubInboundEventReceiver.entityPath = entityPath;
    }

    public static void setPartitionCount(int partitionCount) {
        EventHubInboundEventReceiver.partitionCount = partitionCount;
    }

    public static void setZkStateStore(String zkStateStore) {
        EventHubInboundEventReceiver.zkStateStore = zkStateStore;
    }

    public static void setTargetFqn(String targetFqn) {
        EventHubInboundEventReceiver.targetFqn = targetFqn;
    }
}
