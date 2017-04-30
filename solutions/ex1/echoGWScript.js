session.input.readAsJSON(function (error, json) {
  if (error) {
    console.error("echoGWScript.js: Failed to parse incoming message");
  } else {
    var outputData = {};
    outputData.echo = json;
    session.output.write(outputData);
  }
});
