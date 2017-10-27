package net.java_school.namecard;

import java.util.ArrayList;

public class NamecardManager {
	
	private ArrayList<Namecard> cards= new ArrayList<Namecard>();
	
	public NamecardManager(){}

	public void addCard(Namecard card){
		cards.add(card);					
	}
	
		
		
	public void deleteCard(int no){
	
			int totalCard = cards.size();
			for(int i=0; i<totalCard; i++){
				if (cards.get(i).getNo()== no) {
					cards.remove(cards.get(i));
					break;
				}
			}
		 }
	
	public Namecard getCard(int no){
		Namecard card = null;
		int totalCard = cards.size();
		for(int i=0; i < totalCard; i++) {
			if (cards.get(i).getNo()== no) {
				card = cards.get(i);
				break;
			}
		}
		
		return card;
	}
	
	public ArrayList<Namecard> findCard(String name) {
		ArrayList<Namecard> searchCards = new ArrayList<Namecard>();
		int totalCard = cards.size();
		for(int i = 0; i < totalCard; i++) {
			if (cards.get(i).getName().indexOf(name) != -1) {
				searchCards.add(cards.get(i));
			}
		}
		
		return searchCards;
	}

	public ArrayList<Namecard> getCards() {
		return cards;
	}

}