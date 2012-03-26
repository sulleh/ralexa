Ralexa
======

Ruby client for Amazon Alexa APIs.

These include [Alexa Top Sites][1] and [Alexa Web Information Service][2].

HTTP transport thanks to `Net::HTTP`,
with a little help from [addressable][3].

XML parsing courtesy of [Nokogiri][4].

Thorough test coverage provided by `MiniTest::Spec`.

[1]: http://aws.amazon.com/awis/
[2]: http://aws.amazon.com/alexatopsites/
[3]: https://github.com/sporkmonger/addressable
[4]: http://nokogiri.org/


Installation
------------

```sh
# with bundler
echo 'gem "ralexa"' >> Gemfile
bundle

# or just the gem
gem install ralexa
```


Usage Examples
--------------

```ruby

# grab a Ralexa::Session instance to hold your credentials.
session = Ralexa.session("aws_access_key_id", "aws_secret_access_key")

# all countries
countries = session.top_sites.list_countries

# global top sites
global = session.top_sites.global

# per-country top sites
first_by_country = {}
countries.each do |c|
  first_by_country[c.name] = session.top_sites.country(c.code).first.url
end

# individual country lookup
puts "Top Australian Sites"
session.top_sites.country("AU").each do |s|
  puts "#{s.url} (#{s.page_views} pageviews)"
end

puts "bam!"
```


Status
------

<table>
  <tr>
    <th>Service</th>
    <th>Action</th>
    <th>ResponseGroup</th>
    <th>Supported</th>
  </tr>
  <tr>
    <td rowspan="3">Alexa Top Sites</th>
    <td>TopSites</th>
    <td>Global</th>
    <td>Yes</th>
  </tr>
  <tr>
    <td></th>
    <td>Country</th>
    <td>Yes</th>
  </tr>
  <tr>
    <td></th>
    <td>ListCountries</th>
    <td>Yes</th>
  </tr>
  <tr>
    <td rowspan="5">Alexa Web Information Services</th>
    <td>UrlInfo</th>
    <td>*</th>
    <td>Send a pull request!</th>
  </tr>
  <tr>
    <td>TrafficHistory</th>
    <td>*</th>
    <td>Send a pull request!</th>
  </tr>
  <tr>
    <td>CategoryBrowse</th>
    <td>*</th>
    <td>Send a pull request!</th>
  </tr>
  <tr>
    <td>CategoryListings</th>
    <td>*</th>
    <td>Send a pull request!</th>
  </tr>
  <tr>
    <td>SitesLinkingIn</th>
    <td>*</th>
    <td>Send a pull request!</th>
  </tr>
</table>


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b some-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin some-new-feature`)
5. Create new Pull Request

License
-------

(c) 2012 Flippa, The MIT License.
