<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2013.11.20</div>
			
<h1>Keyword, Identifiers, Comment</h1>

<h2>Keyword</h2>
In a computer language, keywords are reserved word for particular uses. 

<h2>Identifiers</h2>
Identifiers are words which you shoud entitle in your code.

<h3>Rules for Creating Java Identifier</h3>
<ol>
	<li>English alphabetic characters</li>
	<li>White space is not permitted.</li>
	<li>Special Characters are not allowed excpet the `$' and the underscore `_'</li>
	<li>White space is not permitted.</li>
	<li>Not Keyword.</li>
</ol>

<h3>Naming Conventions</h3>
<ol>
	<li>Class names should be nouns which start with an uppercase letter, in mixed case with the first letter of each internal word capitalized. (ex, <em>BankAccount</em>)</li>
	<li>Method names should be verbs which start with a lowercase letter, in mixed case with the first letter of each internal word capitalized. (ex, <em>getName()</em>)</li>
	<li>Variable names should be nouns which start with a lowercase letter, in mixed case with the first letter of each internal word capitalized. 
	Variable names should not start with underline _ or dollar sign $ characters. (ex, <em>accountNo</em>)</li>
	<li>Constant names should be all uppercase with words separated by underlines ("_"). (ex, <em>MAX_BALANCE</em>)</li>
</ol>

<h3>Conventions Example</h3>

<pre class="prettyprint">
package <strong>net.java_school.bank</strong>;//java-school is not permited.

public class <strong>BankAccount</strong> {
	private String <strong>accountNo</strong>; 
	private long <strong>balance</strong>;
	
	public String <strong>getAccountNo</strong>() { 
		return accountNo;
	}
	
	public void <strong>setAccountNo</strong>(String accountNo) { 
		this.accountNo = accountNo;
	}

	public long <strong>getBalance</strong>() { 
		return balance;
	}
}
</pre>

<h2>Comment</h2>
Comments are text which added with the purpose of making the source code easier to understand by a programmer.
They are generally ignored by compilers.<br />
<br />
The Java language supports three kinds of comments. 

<h3>// text</h3>
The compiler ignores everything from // to the end of the line. 

<h3>/* text */</h3>
The compiler ignores everything from /* to */. 

<h3>/** documentation */</h3>
This indicates a documentation comment (doc comment, for short).
The compiler ignores this kind of comment, just like it ignores comments that use /* and */. 
The JDK javadoc tool uses doc comments when preparing automatically generated documentation.