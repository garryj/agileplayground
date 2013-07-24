package org.forms.formService.webService.implementation;

import javax.xml.ws.Endpoint;

public class ServiceStarter {

	/**
	 * http://java.dzone.com/articles/jax-ws-hello-world
	 * @param args
	 */
	
	static String endPoint = "http://localhost:999/FormService";
	public static void main(String[] args) {

		Endpoint.publish(endPoint,new FormServicesImpl());
		System.out.println("Started "+endPoint);
	}
}

