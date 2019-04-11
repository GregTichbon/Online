<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <table width="95%" border="0" cellpadding="10" cellspacing="0" align="center">
      <tr>
        <td>
          <h2>Property Information Feedback</h2>
          Thank you for your feedback.
        </td>
      </tr>
    </table>

    <table width="95%" border="1" cellpadding="10" cellspacing="0" align="center">
      <tr>
        <td align="right" width="50%">Reference number</td>
        <td>
          <xsl:value-of select="root/tb_reference"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Property</td>
        <td>
          <xsl:value-of select="root/tb_property"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Name</td>
        <td>
          <xsl:value-of select="root/tb_applicant"/>
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
      <tr>
        <td align="right" width="50%">Phone details</td>
        <td>
          <xsl:value-of select="root/tb_contactphone"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Detail of data to be reviewed</td>
        <td>
          <xsl:value-of select="root/tb_detail"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Attachments</td>
        <td>
          <xsl:for-each select="root/uploaded/fu_attachments">
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="url"/>
              </xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              <xsl:value-of select="filename"/>
            </a>
            <br />
          </xsl:for-each>
        </td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>

