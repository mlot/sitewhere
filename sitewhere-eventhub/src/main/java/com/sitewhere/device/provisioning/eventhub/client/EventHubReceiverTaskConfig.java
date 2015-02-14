/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *******************************************************************************/
package com.sitewhere.device.provisioning.eventhub.client;


import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

public class EventHubReceiverTaskConfig implements Serializable {

    private static final long serialVersionUID = 1L;
    private final String userName;
    private final String password;
    private final String namespace;
    private final String entityPath;
    private final int partitionCount;

    public String getZkConnectionString() {
        return zkConnectionString;
    }

    private final String zkConnectionString;
    private final int checkpointIntervalInSeconds;
    private final int receiverCredits;
    private final int maxPendingMsgsPerPartition;
    private final long enqueueTimeFilter; //timestamp in millisecond

    private String connectionString;
    private String targetFqnAddress;
    //private IEventDataScheme scheme;

    public EventHubReceiverTaskConfig(String username, String password, String namespace,
                                      String entityPath, int partitionCount, String storeConnectionString) {
        this(username, password, namespace, entityPath, partitionCount,
                storeConnectionString, 300, 1024, 1024, 0);
    }

    //Keep this constructor for backward compatibility
    public EventHubReceiverTaskConfig(String username, String password, String namespace,
                                      String entityPath, int partitionCount, String storeConnectionString,
                                      int checkpointIntervalInSeconds, int receiverCredits) {
        this(username, password, namespace, entityPath, partitionCount,
                storeConnectionString, checkpointIntervalInSeconds, receiverCredits, 1024, 0);
    }

    public EventHubReceiverTaskConfig(String username, String password, String namespace,
                                      String entityPath, int partitionCount, String storeConnectionString,
                                      int checkpointIntervalInSeconds, int receiverCredits, int maxPendingMsgsPerPartition, long enqueueTimeFilter) {
        this.userName = username;
        this.password = password;
        this.connectionString = buildConnectionString(username, password, namespace);
        this.namespace = namespace;
        this.entityPath = entityPath;
        this.partitionCount = partitionCount;
        this.zkConnectionString = storeConnectionString;
        this.checkpointIntervalInSeconds = checkpointIntervalInSeconds;
        this.receiverCredits = receiverCredits;
        this.maxPendingMsgsPerPartition = maxPendingMsgsPerPartition;
        this.enqueueTimeFilter = enqueueTimeFilter;
        //this.scheme = new EventDataScheme();
    }

    public String getConnectionString() {
        return connectionString;
    }

    public String getNamespace() {
        return namespace;
    }

    public String getEntityPath() {
        return entityPath;
    }

    public int getCheckpointIntervalInSeconds() {
        return checkpointIntervalInSeconds;
    }

    public int getPartitionCount() {
        return partitionCount;
    }

    public int getReceiverCredits() {
        return receiverCredits;
    }

    public int getMaxPendingMsgsPerPartition() {
        return maxPendingMsgsPerPartition;
    }

    public long getEnqueueTimeFilter() {
        return enqueueTimeFilter;
    }

    //  public IEventDataScheme getEventDataScheme() {
//    return scheme;
//  }

//  public void setEventDataScheme(IEventDataScheme scheme) {
//    this.scheme = scheme;
//  }

    public List<String> getPartitionList() {
        List<String> partitionList = new ArrayList<String>();

        for (int i = 0; i < this.partitionCount; i++) {
            partitionList.add(Integer.toString(i));
        }

        return partitionList;
    }

    public void setTargetAddress(String targetFqnAddress) {
        this.targetFqnAddress = targetFqnAddress;
        this.connectionString = buildConnectionString(
                this.userName, this.password, this.namespace, this.targetFqnAddress);
    }

    public static String buildConnectionString(String username, String password, String namespace) {
        //String targetFqnAddress = "servicebus.windows.net";
        String targetFqnAddress = "servicebus.chinacloudapi.cn";
        return buildConnectionString(username, password, namespace, targetFqnAddress);
    }

    public static String buildConnectionString(String username, String password,
                                               String namespace, String targetFqnAddress) {
        return "amqps://" + username + ":" + encodeString(password)
                + "@" + namespace + "." + targetFqnAddress;
    }

    private static String encodeString(String input) {
        try {
            return URLEncoder.encode(input, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            //We don't need to throw this exception because the exception won't
            //happen because of user input. Our unit tests will catch this error.
            return "";
        }
    }

}
