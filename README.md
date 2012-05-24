<h2>Bolt</h2>
<p>Bolt is the Content Management System, which allows the end user to publish, edit and modify the content for easy site maintenance from a central page. Bolt is an open source Ruby on Rails Content Management System for Rails 3.</p>

<p>Bolt is developed by Railsfactory which builds products, solutions for entrepreneurs, startups and organizations that are looking for shorter lead times to market using Ruby on Rails. Railsfactory is one of the Asia's largest delivery hub for Ruby on Rails and provides Ruby on Rails Solutions for Web site design, E-Business Solutions, Vertical Search Engine Solutions, Product Engineering and of course, CMS.</p>

<h2>Features of Bolt</h2>

<h6>Bolt</h6>
<ul>
<li>Manage a number of websites with a single instance.</li>
<li>Flexible content type.</li>
<li>User friendly.</li>
<li>Feel good UI.</li>
<li>Works smoothly on Rails.</li>
</ul>

<h2>Getting Started</h2>

<p>Bolt is the great option where the client can easily update their websites, without the necessity of learning new templates or any other complicated things. Bolt is simple, plain and neat!</p>
<h2>For Developers</h2>
<ul>
<li>Easy Customization - The look of the CMS can be easily personalized and made to suit the business needs.</li>
<li>Custom Extensions - Bolt  can extend its functions with custom extensions, which it doesn't do out of the box.</li>
<li>Easy Learning - Bolt sticks to "the Rails way" and does not require learning of any template languages.</li>
<li>Fast and Concise - jQuery is used for fast and concise Javascript.</li>
</ul>

<h2>Installation and Setup</h2>
<p>Bolt installation can be done by following the below steps:</p>
<ul>
<li>Download Bolt application setup.</li>
<li>Double-click on the setup file to start the installation process.</li>
<li>Select the directory to install Bolt Gemfile for existing project or create a new Rails Project.</li>
<li>Add Bolt Gem to your gemfile with command - gem 'bolt'</li>
<li>Install Bolt and it's dependencies using bundler - sudo bundle install</li>

<li>Add your database details to /config/database.yml, if you are adding Bolt to a new project.</li>
<li>To enable Bolt notification emails (for new users and forgotten passwords) add SMTP Server information to your initializers. For example create a new file called initializers/setup_mail.rb and add the following to it:</li>

ActionMailer::Base.delivery_method = :smtp<br/>
ActionMailer::Base.raise_delivery_errors = false<br/>
ActionMailer::Base.smtp_settings = {<br/>
:enable_starttls_auto => false,<br/>
:address => "mail.yourdomain.com",<br/>
:port => 25,<br/>
:domain => "yourdomain.com",<br/>
:user_name => "donotreply@yourdomain.com",<br/>
:password => "whatever",<br/>
:authentication => :login<br/>
}
</p>
<li>Install Bolt configuration files to your new or existing project using the following command. <br/>- <b>bundle exec rails g bolt:install</b></li>
<li>The above command should be run only once to avoid overwriting the customizations when repeated.</li>
<li>Create the new database for the project using the command <br/>- <b>bundle exec rake db:create</b> </li>
<li>If you have an already existing database, then simply migrate the database with the command <br/>- <b>bundle exec rake db:migrate</b></li>
<li>To set the initial user or administrator, use the below command <br/>- <b>bundle exec rake bolt:create_admin email="email address"</b> </li>
<li>Note down the user-name and password displayed</li>
<li>Run the application after a system reboot(if applicable)</li>
<li>Change your password and start using Bolt.</li>
</ul>

<h2>User Authentication:</h2>
<p>Bolt after installation enables the user to set authentication. "Admin" and "User" are the two types of users set up initially. "Admin" can add, edit, modify or delete the users, having complete control over the application. "User" can only modify their own profile. </p>
<h2>Configuration Files:</h2>
<ul>
<li>app/helpers/bolt/config_helper.rb - Allows the user to modify website name, logo, notification e-mail address, dashboard URL etc.</li>
<li>views/bolt/layouts/_left_navigation.html.erb - Configures the left navigation tabs, which can manually be edited and rearranged according to the necessity.</li>
<li>view/bolt/layouts/_right_navigation.html.erb - Configures the right navigation tabs. "Users" tab is added automatically for "Admin" users.</li>
<li>/public/bolt/javascripts/custom.js - This file should be configured by the user. Custom Javascript can be added or modified. Update command does not overwrite this file.</li>
<li>/public/bolt/stylesheets/custom.css - This file should also be configured by the user. Custom Stylesheets can be added, modified or deleted. This file is not overwritten when using Update command.</li>
</ul>

<h2>Support:</h2>
<p>For any suggestions, queries and comments, please contact</p>
<ul>
<li>Email: innovation@railsfactory.org</li>
<li>Web: http://railsfactory.com/</li>
</ul>