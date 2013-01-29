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
p countries.map(&:name)

# global top 250 sites
global = session.top_sites.global(250)

# per-country top sites
first_by_country = {}
countries.each do |c|
  first_by_country[c.name] = session.top_sites.country(c.code, 1).first.url
end

# individual country lookup
puts "Top Ten Australian Sites"
session.top_sites.country("AU", 10).each do |s|
  puts "#{s.url} (#{s.page_views} pageviews)"
end

# rank of an individual site
puts "Rank of Flippa.com"
puts session.url_info.rank("http://flippa.com")

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
    <td rowspan="3">Alexa Top Sites</td>
    <td>TopSites</td>
    <td>Global</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td></td>
    <td>Country</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td></td>
    <td>ListCountries</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td rowspan="6">Alexa Web Information Services</td>
    <td>UrlInfo</td>
    <td>Rank<td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>TrafficHistory</td>
    <td>*</td>
    <td>Send a pull request!</td>
  </tr>
  <tr>
    <td>CategoryBrowse</td>
    <td>*</td>
    <td>Send a pull request!</td>
  </tr>
  <tr>
    <td>CategoryListings</td>
    <td>*</td>
    <td>Send a pull request!</td>
  </tr>
  <tr>
    <td>SitesLinkingIn</td>
    <td>*</td>
    <td>Send a pull request!</td>
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
