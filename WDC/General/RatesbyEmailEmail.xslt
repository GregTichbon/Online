<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <table width="95%" border="0" cellpadding="10" cellspacing="0" align="center">
      <tr>
        <td>
          <h2>Rates by Email Request Acknowledgment</h2>
          Thank you for opting to have your rates notice delivered by email in the future.
        </td>
      </tr>
    </table>

    <table width="95%" border="1" cellpadding="10" cellspacing="0" align="center">
      <!--
      <tr>
        <td align="right" width="50%">Reference number</td>
        <td>
          <xsl:value-of select="root/tb_reference"/>
        </td>
      </tr>
      -->
      <tr>
        <td align="right" width="50%">Property</td>
        <td>
          <xsl:value-of select="root/hf_property_number"/>
          <br /><xsl:value-of select="root/hf_property_address"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Name</td>
        <td>
          <xsl:value-of select="root/tb_name"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Email address</td>
        <td>
          <a>
            <xsl:attribute name="href">
              mailto:<xsl:value-of select="root/tb_emailaddress"/>
            </xsl:attribute>
            <xsl:value-of select="root/tb_emailaddress"/>
          </a>
        </td>
      </tr>
    </table>
    <br />
    <br />
  </xsl:template>
</xsl:stylesheet>

