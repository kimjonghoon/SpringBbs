package net.java_school.javabank;

public class Bank {
	
	private Customer[] customers = new Customer[100];	//°í°´Àº 100¸í±îÁö
	private int totalCustomer;							//ÃÑ °í°´¼ö
	
	public Customer[] getCustomers() {
		return customers;
	}
	
	public void addCustomer(String id, String name) {
		Customer customer = new Customer(id, name);
		customers[totalCustomer++] = customer;
	}
	
	public Customer getCustomer(String id) {
		Customer customer = null;
		for ( int i = 0; i < totalCustomer; i++ ) {
			if ( customers[i].getId().equals(id) ) {
				customer = customers[i];
				break;
			}
		}
		
		return customer;
	}
	
	public int getTotalCustomer() {
		return totalCustomer;
	}
	
}