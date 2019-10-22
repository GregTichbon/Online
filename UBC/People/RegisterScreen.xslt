<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <table class="submissionhead">
      <tr>
        <td align="left"><img src="http://private.unionboatclub.co.nz/dependencies/images/Logo-Page-Head.png" width="350px" />
        </td>
        <td>
          <h2>Union Boat Club Rower Registration</h2>

          <h4>Thank you for your registration.</h4>
          <p></p>
        </td>
      </tr>
    </table>


    <table class="submissiontable">
      <tr>
        <td align="right" width="30%">Use this ID / link to make changes to your registration</td>
        <td>
          <a>
            <xsl:attribute name="href">
              http://ubc.org.nz/people/register.aspx?id=<xsl:value-of select="root/guid"/>
            </xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:value-of select="root/guid"/>
          </a>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">First name</td>
        <td>
          <xsl:value-of select="root/firstname"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Last name</td>
        <td>
          <xsl:value-of select="root/lastname"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Gender</td>
        <td>
          <xsl:value-of select="root/gender"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Date of birth</td>
        <td>
          <xsl:value-of select="root/birthdate"/>
        </td>
      </tr>
      <xsl:if test="string(root/school)">
        <tr>
          <td align="right" width="30%">School</td>
          <td>
            <xsl:value-of select="root/school"/>
          </td>
        </tr>
        <tr>
          <td align="right" width="30%">School year</td>
          <td>
            <xsl:value-of select="root/schoolyear"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td align="right" width="30%">Medical needs</td>
        <td>
          <xsl:value-of select="root/medical"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Special Dietary requirements</td>
        <td>
          <xsl:value-of select="root/dietary"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Email address</td>
        <td>
          <a>
            <xsl:attribute name="href">
              mailto:<xsl:value-of select="root/emailaddress"/>
            </xsl:attribute>
            <xsl:value-of select="root/emailaddress"/>
          </a>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Phone</td>
        <td>
          <table width="100%" border="1" cellpadding="10" cellspacing="0" align="center">
            <thead>
              <tr>
                <th>Number</th>
                <th>Type</th>
                <th>Note</th>
              </tr>
            </thead>
            <tbody>
            <xsl:for-each select="root/PhoneRepeater/Phone">
              <tr>
                <td style="text-align:left">
                  <xsl:value-of select="number"/>
                </td>
                <td style="text-align:left">
                  <xsl:value-of select="type"/>
                </td>
                <td style="text-align:left">
                  <xsl:value-of select="note"/>
                </td>
              </tr>
            </xsl:for-each>
            </tbody>
          </table>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Home address</td>
        <td>
          <xsl:call-template name="break">
            <xsl:with-param name="text" select="root/residentialaddress" />
          </xsl:call-template>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Swimming ability</td>
        <td>
          <xsl:value-of select="root/swimmer"/>
        </td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:left">
          <h2>Financial</h2>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Invoices/statements etc sent to</td>
        <td>
          <xsl:value-of select="root/invoicerecipient"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Sent by</td>
        <td>
          <xsl:value-of select="root/invoicetype"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Address</td>
        <td>
          <xsl:value-of select="root/invoiceaddress"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Note</td>
        <td>
          <xsl:value-of select="root/invoicenote"/>
        </td>
      </tr>
      <xsl:if test="string(root/ParentRepeater)">
        <tr>
          <td colspan="2" style="text-align:left">
            <h2>Parent(s) / Caregiver(s)</h2>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <table width="100%" border="1" cellpadding="10" cellspacing="0" align="center">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Relationship</th>
                  <th>Email</th>
                  <th>Note</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="root/ParentRepeater/Parent">
                  <tr>
                    <td style="text-align:left">
                      <b>
                        <xsl:value-of select="name"/>
                      </b>
                    </td>
                    <td style="text-align:left">
                      <xsl:value-of select="relationship"/>
                    </td>
                    <td style="text-align:left">
                      <xsl:value-of select="email"/>
                    </td>
                    <td style="text-align:left">
                      <xsl:value-of select="note"/>
                    </td>
                  </tr>
                  <xsl:for-each select="Phone">
                    <tr>
                      <td style="text-align:left">
                        <xsl:value-of select="number"/>
                      </td>
                      <td style="text-align:left">
                        <xsl:value-of select="type"/>
                      </td>
                      <td style="text-align:left" colspan="2">
                        <xsl:value-of select="note"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </xsl:for-each>
              </tbody>
            </table>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td colspan="2" style="text-align:left">
          <h2>Membership</h2>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Type</td>
        <td>
          <xsl:value-of select="root/membershiptype"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Other immediate family who are members of Union Boat Club</td>
        <td>
          <xsl:value-of select="root/familydiscount"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Previous Club</td>
        <td>
          <xsl:value-of select="root/previousclub"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">Boat currently stored at UBC</td>
        <td>
          <xsl:value-of select="root/boatinstorage"/>
        </td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:left">
          <h2>Declaration</h2>
          <ul>
            <li>I hereby apply for membership of the Union Boat Club.</li>
            <li>I agree to be bound by the rules of the Club and to pay the annual subscription fees as set at the Annual General Meeting.</li>
            <li>I also agree to pay such additional fees and levies which may be set from time to time to cover such items as: regatta entries, racing seat fees and travel expenses.</li>
            <li>I understand that there may be risk of personal injury involved in participating in the sport of rowing and hereby indemnify the Union Boat Club, its Executive, fellow members and coaches from any liability.</li>
          </ul>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">I agree with the above statements.</td>
        <td>
          <xsl:value-of select="root/agreement"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="30%">I also agree, for my information to held in the Union Boat Club database to receive email and text messages from the club.</td>
        <td>
          <xsl:value-of select="root/correspondence"/>
        </td>
      </tr>
      <!--
        <tr>
            <td>Attachments</td>
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
            -->
    </table>
    <p> </p>

  </xsl:template>
  <xsl:template name="break">
    <xsl:param name="text" select="string(.)"/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#xa;')">
        <xsl:value-of select="substring-before($text, '&#xa;')"/>
        <br/>
        <xsl:call-template name="break">
          <xsl:with-param
            name="text"
            select="substring-after($text, '&#xa;')"
        />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>