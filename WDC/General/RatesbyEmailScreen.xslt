<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <body>
        <h2>Rates by Email Request Acknowledgment</h2>
       
        <table class="submissionhead">
          <tr>
            <td>
              Thank you for opting to have your rates notice delivered by email in the future.
            </td>
          </tr>
        </table>
        <table class="submissiontable">
          <!--
          <tr>
            <td>Reference number</td>
            <td>
              <xsl:value-of select="root/tb_reference"/>
            </td>
          </tr>
          -->
          <tr>
            <td>Property</td>
            <td>
              <xsl:value-of select="root/hf_property_number"/>
              <br />
              <xsl:value-of select="root/hf_property_address"/>
            </td>
          </tr>
          <tr>
              <td>Name</td>
              <td>
                <xsl:value-of select="root/tb_name"/>
              </td>
            </tr>
            <tr>
              <td>Email address</td>
              <td>

                <a>
                  <xsl:attribute name="href">mailto:<xsl:value-of select="root/tb_emailaddress"/>
                  </xsl:attribute>
                  <xsl:value-of select="root/tb_emailaddress"/>
                </a>
              </td>
            </tr>
           
          
        </table>
        <br />
        <br />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

