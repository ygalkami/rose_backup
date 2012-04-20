#include <math.h>
#include "stdlib.h"

class Node;
class ListNode{
private:
	void* obj;
	ListNode* next;
public:
	void* get(){
		return obj;
	}
	ListNode* getNext() {
		return next;
	}
	ListNode(){
		obj=NULL;
		next=NULL;
	}
	ListNode(void* stuff){
		obj=stuff;
		next=NULL;
	}
	bool add(void* stuff){
		if(next==NULL){
			next = (ListNode*)malloc(sizeof(ListNode));
			*next = ListNode(stuff);
		}
		else{
			next->add(stuff);
		}
		return 1;
	}
};
class LList{
private:
	ListNode* Start;
	int size;
public:
	LList(){
		Start = (ListNode*)malloc(sizeof(ListNode));
		*Start = ListNode();
	}
	int add(void* stuff){
		Start->add(stuff);
		size+=1;
		return size;
	}
	ListNode* getFirst(){
		return Start;
	}
};
class LListIterator{
private:
	LList* List;
	ListNode* Node;
public:
	LListIterator(LList* list){
		List=list;
		Node=list->getFirst();
	}
	ListNode* Next(){
		ListNode* tmp = Node;
		Node = Node->getNext();
		return tmp;
	}
	bool hasNext(){
		if(Node!=NULL){
			return 1;
		}
		return 0;
	}

};


class Node{
private:
	LList dependencies;
	LList weights;
	bool dirty;
public:
	float output;
	
	Node(){
		dependencies=LList();
		weights=LList();
		dirty=1;
		output=0.0f;
	}
	float getOutput(){
		return output;
	}
	void UpdateOutput(){
		float max=0.0f;
		LListIterator nodes = LListIterator(&dependencies);
		LListIterator vals = LListIterator(&weights);
		while(nodes.hasNext()){
			output+=(*(float*)(vals.Next())->get())* ((Node*)(vals.Next())->get())->getOutput();
			max+=1;
		}
		output/=max;
	}
	void addNode(Node* node,float weight){
		dependencies.add(node);
		float* bob=(float*)malloc(4);
		*bob=weight;
		weights.add(bob);
	}
};

class inNode : Node{
public:
	void setOutput(float value){
		output=value;
	}
	inNode(){
		output=0.0f;
	}
};

class Network{
private:
	LList inlayer;
	LList hlayer1;
	LList outlayer;
public:
	Network(){
		inlayer=LList();
		for(int i=0;i<15;i++){
			inNode* bob = (inNode*)malloc(sizeof(inNode));
			*bob = inNode();
			inlayer.add(bob);
		}
		for(int i=0;i<8;i++){
			Node* bob = (Node*)malloc(sizeof(Node));
			*bob = Node();
			hlayer1.add(bob);
			LListIterator iter = LListIterator(&inlayer);
			for(int j=0;j<15;j++){
				bob->addNode((Node*)iter.Next()->get(),(rand()*1.0f)/RAND_MAX);
			}
		}
		for(int i=0;i<4;i++){
			Node* bob = (Node*)malloc(sizeof(Node));
			*bob = Node();
			outlayer.add(bob);
			LListIterator iter = LListIterator(&hlayer1);
			for(int j=0;j<8;j++){
				bob->addNode((Node*)iter.Next()->get(),(rand()*1.0f)/RAND_MAX);
			}
		}
	}
	void pushInputs(bool barray[15]){
		LListIterator iter = LListIterator(&inlayer);
		int i = 0;
		while(iter.hasNext()){
			inNode* bob = (inNode*)iter.Next();
			bob->setOutput(barray[i]);
			i++;
		}
	}
	bool* pullOutputs(){
		LListIterator iterhidden = LListIterator(&hlayer1);
		LListIterator iterout = LListIterator(&outlayer);
		while(iterhidden.hasNext()){
			((Node*)iterhidden.Next()->get())->UpdateOutput();
		}
		while(iterout.hasNext()){
			((Node*)iterout.Next()->get())->UpdateOutput();
		}
		LListIterator iterfinal = LListIterator(&outlayer);
		int i = 0;
		bool barray[4];
		while(iterfinal.hasNext()){
			Node* bob = (Node*)iterfinal.Next();
			barray[i] = (bob->getOutput())>0.6f?1:0;
			i++;
		}
		return barray;
	}

};