/*
 * Copyright (c) SiteWhere, LLC. All rights reserved. http://www.sitewhere.com
 *
 * The software in this package is published under the terms of the CPAL v1.0
 * license, a copy of which has been included with this distribution in the
 * LICENSE.txt file.
 */
package com.sitewhere.device.event.processor;


import com.sitewhere.spi.SiteWhereException;
import com.sitewhere.spi.device.event.processor.IInboundEventProcessor;
import com.sitewhere.spi.device.event.request.*;
import org.apache.log4j.Logger;

/**
 * Implementation of {@link IInboundEventProcessor} that attempts to store the inbound
 * event request using device management APIs.
 */
public class XiaoIceEventProcessor extends InboundEventProcessor {

    /**
     * Static logger instance
     */
    private static Logger LOGGER = Logger.getLogger(XiaoIceEventProcessor.class);

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.spi.server.lifecycle.ILifecycleComponent#start()
     */
    @Override
    public void start() throws SiteWhereException {
        getLogger().info("XiaoIceEventProcessor started.");
    }

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.spi.server.lifecycle.ILifecycleComponent#getLogger()
     */
    @Override
    public Logger getLogger() {
        return LOGGER;
    }

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.spi.server.lifecycle.ILifecycleComponent#stop()
     */
    @Override
    public void stop() throws SiteWhereException {
        getLogger().info("XiaoIceEventProcessor stopped.");
    }

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.rest.model.device.event.processor.InboundEventProcessor#
     * onRegistrationRequest(java.lang.String, java.lang.String,
     * com.sitewhere.spi.device.event.request.IDeviceRegistrationRequest)
     */
    @Override
    public void onRegistrationRequest(String hardwareId, String originator, IDeviceRegistrationRequest request)
            throws SiteWhereException {

        //todo add your logic to handle device registration event
        getLogger().info("XiaoIceEventProcessor onRegistrationRequest called.");


    }

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.rest.model.device.event.processor.InboundEventProcessor#
     * onDeviceCommandResponseRequest(java.lang.String, java.lang.String,
     * com.sitewhere.spi.device.event.request.IDeviceCommandResponseCreateRequest)
     */
    @Override
    public void onDeviceCommandResponseRequest(String hardwareId, String originator,
                                               IDeviceCommandResponseCreateRequest request) throws SiteWhereException {

        //todo add your logic to handle device command event
        getLogger().info("XiaoIceEventProcessor onDeviceCommandResponseRequest called.");


    }

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.rest.model.device.event.processor.InboundEventProcessor#
     * onDeviceMeasurementsCreateRequest(java.lang.String, java.lang.String,
     * com.sitewhere.spi.device.event.request.IDeviceMeasurementsCreateRequest)
     */
    @Override
    public void onDeviceMeasurementsCreateRequest(String hardwareId, String originator,
                                                  IDeviceMeasurementsCreateRequest request) throws SiteWhereException {

        //todo add your logic to handle device measurement event
        getLogger().info("XiaoIceEventProcessor onDeviceMeasurementsCreateRequest called.");

    }

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.rest.model.device.event.processor.InboundEventProcessor#
     * onDeviceLocationCreateRequest(java.lang.String, java.lang.String,
     * com.sitewhere.spi.device.event.request.IDeviceLocationCreateRequest)
     */
    @Override
    public void onDeviceLocationCreateRequest(String hardwareId, String originator,
                                              IDeviceLocationCreateRequest request) throws SiteWhereException {

        //todo add your logic to handle device location event
        getLogger().info("XiaoIceEventProcessor onDeviceLocationCreateRequest called.");
    }

    /*
     * (non-Javadoc)
     *
     * @see com.sitewhere.rest.model.device.event.processor.InboundEventProcessor#
     * onDeviceAlertCreateRequest(java.lang.String, java.lang.String,
     * com.sitewhere.spi.device.event.request.IDeviceAlertCreateRequest)
     */
    @Override
    public void onDeviceAlertCreateRequest(String hardwareId, String originator,
                                           IDeviceAlertCreateRequest request) throws SiteWhereException {

        //todo add your logic to handle device alert event
        getLogger().info("XiaoIceEventProcessor onDeviceAlertCreateRequest called.");
    }

}