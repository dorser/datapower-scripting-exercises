<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:json="http://www.ibm.com/xmlns/prod/2009/jsonx">

  <xsl:template match="/">
      <xsl:element name="json:object">
        <xsl:element name="json:object">
            <xsl:attribute name="name">
              <xsl:copy-of select="/*[local-name()='object']/*[local-name()='string'][@*[local-name()='name']='model']/text()"/>
            </xsl:attribute>
            <xsl:copy-of select="/json:object/node()"/>
        </xsl:element>
      </xsl:element>
  </xsl:template>
</xsl:stylesheet>
