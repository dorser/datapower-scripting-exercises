<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:json="http://www.ibm.com/xmlns/prod/2009/jsonx">

  <xsl:template match="/">
      <xsl:element name="echo">
        <xsl:copy-of select="/"/>
      </xsl:element>
  </xsl:template>
</xsl:stylesheet>
