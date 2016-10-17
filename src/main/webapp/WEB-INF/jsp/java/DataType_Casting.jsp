<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2016.4.7</div>

<h1>Data Type and Type Casting</h1>


<h2>Literal and Variable</h2>

<pre class="prettyprint no-border">
int year = 2016;
</pre>

The programming elements as the <b>2016</b> called Literal.
A literal is the source code representation of a fixed value.
<br />
The programming elements as the <b>year</b> called Variable.
A variable is a storage location with a name in order to save the value.
The size of storage capacity varies depending on the Data Type.

<h2>Data Type</h2>

Data type in Java is largely divided into two types.

<ul>
	<li>Primitive Data Types</li>
	<li>Reference Data Types</li>
</ul>

Primitive Data Types are a Data Type for normal data.
Reference Data Types are a Data Type for reference data.

<h3>Primitive Data Types</h3>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">Type</th>
	<th class="table-in-article-th">Description</th>
	<th class="table-in-article-th">Example</th>
</tr>
<tr>
	<th class="table-in-article-th">boolean</th>
	<td class="table-in-article-td">true or false</td>
	<td class="table-in-article-td">boolean present = true;</td>
</tr>
<tr>
	<th class="table-in-article-th">char</th>
	<td class="table-in-article-td">
		16-bit Unicode character.<br />
		Always use 'single quotes' for char literals.
	</td>
	<td class="table-in-article-td">
		char grade = 'A';<br />
		char ch = '\uFFFF';<br />
		('\uFFFF' is the character correspond to FFFF (Hex) in UTF-16)<br />
		char ech = '\n';//line feed<br />
		char ech = '\b';//backspace<br />
		char ech = '\t';//tab<br />
		char ech = '\\';//backspace<br />
		char ech = '\"';//double quote<br />
		char ech = '\'';//single quote
	</td>
</tr>
<tr>
	<th class="table-in-article-th">byte</th>
	<td class="table-in-article-td">8-bit integer</td>
	<td class="table-in-article-td">byte weight = 71;</td>
</tr>
<tr>
	<th class="table-in-article-th">short</th>
	<td class="table-in-article-td">16-bit integer</td>
	<td class="table-in-article-td">short bill = 30000;</td>
</tr>
<tr>
	<th class="table-in-article-th">int</th>
	<td class="table-in-article-td">32-bit integer</td>
	<td class="table-in-article-td">int balance = 56219618;</td>
</tr>
<tr>
	<th class="table-in-article-th">long</th>
	<td class="table-in-article-td">64-bit integer</td>
	<td class="table-in-article-td">long balance = 56219000L;</td>
</tr>
<tr>
	<th class="table-in-article-th">float</th>
	<td class="table-in-article-td">32-bit floating point
	<td class="table-in-article-td">float rate = 6.195f;</td>
</tr>
<tr>
	<th class="table-in-article-th">double</th>
	<td class="table-in-article-td">64-bit floating point</td>
	<td class="table-in-article-td">double rate = 6.195;</td>
</tr>
</table>

<h3>Data Type of Values</h3>

<pre class="prettyprint no-border">
int i1 = 3;//integral number without any additional character is a int literal.
int i2 = 3000000000;//compile error!
</pre>

3000000000 is a int literal and value of the int type should be created. 
But 3000000000 is out of the int range so that value of 3000000000 cannot be created.
<br />


<pre class="prettyprint no-border">
long money = 1000L;//1000L is a long literal. 
</pre>

<pre class="prettyprint no-border">
double d1 = 3.14;//A floating point number without any additional character is a double literal. 
double d2 = 3.14D;//3.14D is a double literal.
double d3 = 3.14d;//3.14d is a double literal.
</pre>

<pre class="prettyprint no-border">
float f2 = 3.14f;//3.14f is a float literal.
float f3 = 3.14F;//3.14F is a float literal.
</pre>

<h3>int literals may not be int value</h3>
There is no specific literal for the byte and short in Java.
As below shown, a int literals may not be int value.

<pre class="prettyprint no-border">
byte b = 1; //1 is int literal but value of 1 is created as byte type.
</pre>

<pre class="prettyprint no-border">
short s = 2; //2 is int literal but value of 2 is created as short type.
</pre>

<h3>Reference Data Types</h3>

<pre class="prettyprint no-border">
Student john = new Student();
</pre>

To declare a variable in Java, you should put the data type of the variable before the variable name. 
Student is the data type of the variable john and Student is not primitive data type.
therefore, Student is a reference data type.
When new Student() is executed, the reference to created student object is assigned to the varible john.
A reference to an object is the address of the object in memory.
Now, if you use the varibale john and .(dot), you can access to the student object which john is referring to as below;

<pre class="prettyprint no-border">
john.name = "John Adams";
</pre>

if you want that john is not referring to any object, assign null to john as below;

<pre class="prettyprint no-border">
john = null;
</pre>

<h2>Type Casting</h2>

Type casting means that converting the data type of value to desired data type.
Type Casting is divided into two types.
One is called Up-Casting, it happens automatically by the JVM.
The Other is called Down-Casting, if you want it happens, put (desired data type) before literals or variables. 
 
<h3>Up-Casting</h3>

<pre class="prettyprint no-border">
long money = 300;//300 is int literal and value of 300 is created as int type.
</pre>

The above code has been declared a long type variable money and assign 300 to money.
Java is strict on the data type applies. So, variable money shall be assigned a value of long type. 
In this case, JVM converted 300 of int type to 300 of long type before the assignment.
Automatic type casting happens to a large datatypes direction from a small data type.<br />
(byte --&gt; short --&gt; int --&gt; long --&gt; float --&gt; double)<br />
So, it is called Up-Casting.
Even so float occupies 4 bytes of memory size and long occupies 8 bytes of memory size, but long are automatically cast to float.

<pre class="prettyprint no-border">
float x = 10L;//JVM convert 10 of long type to 10 of float type automatically.
</pre>

<h4>Automatic Type Casting in arithmetic</h4>

<pre class="prettyprint no-border">
int x = 3 + <em>3.5</em> + 4; //compile error!
</pre>

Value of 3.5 is created as a double type and value of 3 and 4 are created as int type.
In the arithmetic which int type and larger type than int participates in, 
every value will converted to the largest data type of values as below;

<pre class="prettyprint no-border">
int x = 3.0 + 3.5 + 4.0;
</pre>

Compile error happens because you cannot assign long to int.<br />
<br />
Let's try to predict the value of z in the next example.<br />

<pre class="prettyprint no-border">
int x = 10; int y = 4; int z = x / y;
</pre>

z assigned 2 (not 2.5).
The reason is because both x and y are int that result also be a int.<br />

Try again.
<pre class="prettyprint no-border">
int x = 10; int y = 4; double z = x / y;
</pre>

<h3>Down-Casting</h3>

<pre class="prettyprint no-border">
float f = 1.1;// compile error!
</pre>

The above code occurs a compile error because you cannot assign double to float.
The following code converts value of double type to value of float type.

<pre class="prettyprint no-border">
float f = (float) 1.1;
</pre>

Consider the following example.

<pre class="prettyprint no-border">
byte b = (byte) 258; //b assigned 2
</pre>

When int converts to byte, front 3 bytes of 4 bytes is lost.<br />
<br />
Let's consider the previous example.<br />
if you want that z is 2.5, you need to do the down-casting as below;

<pre class="prettyprint no-border">
double z = (double) x / y; or double z = x / (double) y;
</pre>

<h3>Arithmetic which byte or short participates in</h3>

In arithmetic that values of byte or short participate in, all values converted to int type before the arithmetic progress.


<pre class="prettyprint no-border">
short s1 = 1;
short s2 = 2;
short sum = s1 + s2; //compile error!
</pre>

If you want to avoid compilation errors. cast as shown below; 

<pre class="prettyprint no-border">
short sum = <em>(short)</em> (s1 + s2);
</pre>

or

<pre class="prettyprint no-border">
<em>int</em> sum = s1 + s2;
</pre>

<h2>To use strings in Java programs</h2>

How to express the strings in Java is to create a String object from the String class. 
The String class is a class that exists in the Java API. 

<pre class="prettyprint no-border">
char[] arrayOfHello = {'H','e','l','l','o'};
String greetings = new String(arrayOfHello);
</pre>

However, since strings are often used, Java allows the following.

<pre class="prettyprint no-border">
String greetings = "Hello"; //Here, "Hello" is a Java Literal.
</pre>

<span id="refer">References</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html">http://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html</a></li>
	<li><a href="http://stackoverflow.com/questions/4331200/what-do-f-and-d-mean-at-the-end-of-numeric-literals">http://stackoverflow.com/questions/4331200/what-do-f-and-d-mean-at-the-end-of-numeric-literals</a></li>
	<li><a href="http://en.wikipedia.org/wiki/Literal_%28computer_programming%29">http://en.wikipedia.org/wiki/Literal_%28computer_programming%29</a></li>
</ul>