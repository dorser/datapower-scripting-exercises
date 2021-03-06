# DataPower Scripting Exercises

These exercises are an entry level exercises that should get you started with XSLT and GatewayScript for DataPower.

We assume you have basic knowledge configuring DataPower already.

It is advised to use the documentation, so make sure the DataPower knowledge center is available and open.

For GWScript: https://www.ibm.com/support/knowledgecenter/en/SS9H2Y_7.5.0/com.ibm.dp.doc/gatewayscript_model.html

For XSLT: https://www.ibm.com/support/knowledgecenter/en/SS9H2Y_7.5.0/com.ibm.dp.doc/extensions_introduction.html

This lab doesn't cover XQuery/JSONiq.

## Creating a test service

### First things first.

As you already know, we don't configure any applicative definitions on domain default, therefore we will create a new application domain.

Don't forget to save the configuration!

Switch to the application domain to start configuring your service.

### Creating the service

Let's start by creating a "loopback" service that will assist us in testing.

Please create a MPGW and configure it as follows:

* Create an HTTP Front Side Handler.
  * For the Address, choose 0.0.0.0
  * For the port, choose 8000
* Select "Dynamic-Backends" at the backside settings.
* For the Request type and Response type choose JSON.
* Create a new Policy and define a client-to-server rule.
  * Create a match action that matches the URL "/GWScript".
  * Drag an Advanced action, double click it and choose "Set Variable" Action.
    * In the set variable action, populate the service variable "var://service/mpgw/skip-backside" with the value of 1.
* Now create a new client-to-server rule.
  * Create a match action the matches the URL "/XSLT".
  *Drag an Advanced action, double click it and choose "Set Variable" Action.
    *In the set variable action, populate the service variable "var://service/mpgw/skip-backside" with the value of 1.

This should get us started.

## 1. Creating an "echo service" using GWScript

In GWScript, we can access the input, output and other contexts from the session object.
In order "to read" the incoming input, we need to specifiy the input context and the method to use in order to read the message with supported parsers (JSON/XML/Buffer).

Since our input is JSON, in order to read the input as a JSON object we will use the following snippet:
```
session.input.readAsJSON(function (error, json) {
  if (error) {
    // Handle Error
  } else {
    // Logic  
  }
});
```

If readAsJson fails to parse the incoming message, the error variable will be populated.
We can access the input from the json value (it is a JSON object).

For the output context, we have a write method.
we can use it the following way:
```
session.output.write();
```

### What should we do?

Please write an echo service that reads the input such as:
```
{
  "message" : "hello"
}
```

and outputs:
```
{
  "echo" : {
    "message" : "hello"
  }
}
```

Save it as a .js file and choose it as a GatewayScript action.

If you are struggling, please refer to the suggested documentation before consulting the instructor.

**Please make sure that the Content-Type of the response is application/json. There are many different way to achieve this**


## 2. Creating an "echo service" using XSLT

Since we are working with JSON input and normally XSLT expects XML input, we will be working with JSONx as it was presented in class.

Make sure you convert the input to JSONx, as you remember there are two methods, make sure you choose the preferable one.

In XSLT a generic template would look like:
```
<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

  <xsl:template match="/">
    <!-- Logic -->
  </xsl:template>
</xsl:stylesheet>
```

The ```<xsl:copy></xsl:copy>``` or ```<xsl:copy-of select="..."/>``` commands write to the output.

For the given input:
```
{
  "message" : "hello"
}
```

Please output the following:
```
<echo>
  <json:object xsi:schemaLocation="http://www.datapower.com/schemas/json jsonx.xsd"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:json="http://www.ibm.com/xmlns/prod/2009/jsonx">
    <json:string name="message">Hello</json:string>
  </json:object>
</echo>
```

Save your XSLT as .xsl file and choose it for the Transform action in your XSLT rule.

Test it and see if you get the expected output.

## 3. Pushing our XSLT "echo service" forward:

Now, let's try and generate a JSON output from that rule.

Think how you would do that. The expected output is:

```
{
  "echoFromXslt" : {
    "message" : "hello"
  }
}
```

If you are struggling, make sure you read through: https://www.ibm.com/support/knowledgecenter/SS9H2Y_7.5.0/com.ibm.dp.doc/json_jsonxconversionrules.html
