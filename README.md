# masala_base

This is a component of the [masala toolkit](https://github.com/PaytmLabs/masala).

This is a [base cookbook](http://blog.vialstudios.com/the-environment-cookbook-pattern/#thebasecookbook) that is used to provide system-level setup. It uses a number of application cookbooks to provide a standardized operating environment across a number of platforms. A number of other cookbooks in the masala suite rely on this base cookbook, as does the tooling.

## Supported Platforms

The platforms supported are:
- Centos 6.7+ / Centos 7.1+
- Ubuntu 14.04 LTS (And future LTS releases)
- Debioan 8.2+

## Attributes

Please also see the documentation for the cookbooks included by masala_base. (See [metadata.rb](https://github.com/PaytmLabs/masala_base/blob/develop/metadata.rb) file)

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['masala_base']['img_build']</tt></td>
    <td>Boolean</td>
    <td>A flag that is set when building images with packer, to signal to coobooks they are running in that context. Used to skip/add certain tasks as appropriate.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['install_jdk']</tt></td>
    <td>Boolean</td>
    <td>A flag to control if the JDK will be installed as part of the base. Useful when multiple cookbooks are requiring java, to ensure top-level control over flavour/version used.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['gateway_interface']</tt></td>
    <td>String</td>
    <td>When the system to be configured has multiple interfaces with default routes, which interface to favour for outbound routes.</td>
    <td><tt>eth0</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['upgrade_ixgbevf']</tt></td>
    <td>Boolean</td>
    <td>Will use DKMS to configure/install an updated version of the ixgbevf kernel driver. Main use is for enabling enhanced networking in AWS instances</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['admin']['user']</tt></td>
    <td>String</td>
    <td>Login name for an admin user to setup on the system. Commonly used for setting up vagrant user in development images, but can be used to setup a common user as well.</td>
    <td><tt>masala</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['admin']['group']</tt></td>
    <td>String</td>
    <td>Group name for admin user</td>
    <td><tt>masala</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['admin']['ssh_pubkey']</tt></td>
    <td>String</td>
    <td>A publish SSH key that will be configured into the admin user's ~/.ssh/authorized_keys file.</td>
    <td><tt>true</tt></td>
  </tr>
# array of optional data dog tags to add to primary ones
default['masala_base']['dd_extra_tags'] = []
  <tr>
    <td><tt>['masala_base']['dd_enable']</tt></td>
    <td>Boolean</td>
    <td>Enable installation of [DataDog](https://www.datadoghq.com/) agent</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['dd_api_key']</tt></td>
    <td>String</td>
    <td>API key for DataDog reporting. Setting is required to enable DataDog agent.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['dd_handler_enable']</tt></td>
    <td>Boolean</td>
    <td>Enable the chef handler for reporing information on chef runs to DataDog</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['dd_app_key']</tt></td>
    <td>String</td>
    <td>Application key for DataDog handler reporting. Setting this is necessary to enable handler.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['dd_extra_tags']</tt></td>
    <td>Array of Strings</td>
    <td>Additional tags to apply to the DataDog agent on this system. These are in addition to core tags (see below)</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['machine_tags']['environment']</tt></td>
    <td>String</td>
    <td>One of the mandatory tags, environment should generally match the chef environment setting.</td>
    <td><tt>no_name</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['machine_tags']['application']</tt></td>
    <td>String</td>
    <td>One of the mandatory tags, application defines a group of relates services/systems.</td>
    <td><tt>no_name</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['machine_tags']['cluster']</tt></td>
    <td>String</td>
    <td>One of the mandatory tags, cluster is a label for a single cluster of a given service. Should match any internal representation of cluster name for that service.</td>
    <td><tt>no_name</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['machine_tags']['role']</tt></td>
    <td>String</td>
    <td>One of the mandatory tags, specifies the service role of a given system. Does NOT relate to chef roles. Examples: cassandra, ldap-master, kafka.</td>
    <td><tt>not_defined</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['machine_tags']['owner']</tt></td>
    <td>String</td>
    <td>One of the mandatory tags, owner specifies a stakeholder interest in a system. Usually this is the entity responsible for the costs of running the system.</td>
    <td><tt>no_name</tt></td>
  </tr>
  <tr>
    <td><tt>['masala_base']['machine_tags']['dc']</tt></td>
    <td>String</td>
    <td>One of the mandatory tags, dc specifies the datacenter location of a system.</td>
    <td><tt>no_name</tt></td>
  </tr>

  <tr>
    <td><tt>['masala_base']['issue_text']</tt></td>
    <td>String</td>
    <td>Text that will become part of the issue.net, to be emitted when connecting via SSH, but prior to authentication. When used with the masala tooling, this value will be injected from a file.</td>
    <td><tt>(An ASCII art version of the work Masala)</tt></td>
  </tr>
</table>

## Usage

### masala_base::default

Include `masala_base` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[masala_base::default]"
  ]
}
```

More typically, this recipe will be run as a dependency from another cookbook in the Masala family.

## License, authors, and how to contribute

See:
- [LICENSE](https://github.com/PaytmLabs/masala_base/blob/develop/LICENSE)
- [MAINTAINERS.md](https://github.com/PaytmLabs/masala_base/blob/develop/MAINTAINERS.md)
- [CONTRIBUTING.md](https://github.com/PaytmLabs/masala_base/blob/develop/CONTRIBUTING.md)

