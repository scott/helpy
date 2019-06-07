# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Contains Seeds specific to the DO image!

# Users
admin = User.create!(
  name: 'Admin',
  login:'admin',
  email: 'admin@test.com',
  password:'12345678',
  role: 'admin',
  thumbnail: '',
  medium_image: '',
  large_image: '',
  admin: true
)

bot = User.create!(
  name: 'Helpy Bot',
  login:'helpybot',
  email: 'noreply@helpy.io',
  password:'12345678',
  role: 'user',
  admin: false,
  active: false
)

user_scott = User.create!(
  name: 'Scott Miller',
  login: 'scott',
  email: 'scott+demo@helpy.io',
  password: '12345678',
  role: 'user',
  admin: false,
  bio: 'I am the creator of Helpy.io, the open source helpdesk alternative. Welcome to the system!',
  linkedin: 'http://www.linkedin.com/in/optimizeit',
  thumbnail: '14369.jpg',
  medium_image: '14369.jpg',
  large_image: '14369.jpg',
  company: ''
)

tag = ActsAsTaggableOn::Tag.create(name: 'sales', description: 'Sales Inquiries')
ActsAsTaggableOn::Tagging.create(tag_id: tag.id, context: "teams")

tag = ActsAsTaggableOn::Tag.create(name: 'billing', description: 'Billing Inquiries')
ActsAsTaggableOn::Tagging.create(tag_id: tag.id, context: "teams")

tag = ActsAsTaggableOn::Tag.create(name: 'tier_one', description: 'Tier one support')
ActsAsTaggableOn::Tagging.create(tag_id: tag.id, context: "teams")

tag = ActsAsTaggableOn::Tag.create(name: 'tier_two', description: 'Tier two support')
ActsAsTaggableOn::Tagging.create(tag_id: tag.id, context: "teams")

# Forums
Forum.destroy_all

Forum.create(
  name: "Private Tickets",
  description: "Private Messages to Support",
  private: true
)
Forum.create(
  name: "Trash",
  description: "Deleted tickets go here",
  private: true
)
Forum.create(
  name: "Doc comments",
  description: "Contains comments to docs",
  private: true
)
community = Forum.create(
  name: "General tickets",
  description: "This is an example of a normal community forum."
)

Category.destroy_all
Doc.destroy_all

# System Required Knowledgebase Categories
Category.create!(name:'Common Replies', title_tag: 'Common Agent Replies', meta_description: 'Common replies to questions (Visible only to agents)', front_page: false, active: false)
templates = Category.create!(name:'Email templates', title_tag: 'Email Templates',  meta_description: 'Emails used by the system', front_page: false, active: false)

# Example Categories
category = Category.create!(name:'Welcome to Helpy',icon: 'eye-open', title_tag: 'Welcome to your Helpy', meta_description: 'Learn how to set up your Helpy self service knowledgebase', front_page: true)

# Create some docs
category.docs.create!(
  title: "Welcome to your knowledge base",
  user_id: bot.id,
  body: "
  This is what an article looks like in your knowledgebase.  You can add and remove articles and categories in the admin section of Helpy.
  <br/><br/>
  Every published article is also automatically indexed in the Helpy
  internal search engine.  So that means if you search for “Whatchamacallit”
  (go ahead and give this a try in the search bar), you will find yourself
  right back at this article.
  <br/><br/>
  We have left the job of deciding on categories to you, but to get you
  started things like “How it works”, “FAQs”, and “Getting Started” are
  popular categories.
  <br/><br/>
  The important (and amazing) thing about the knowledgebase is that the
  more you provide, and the better that content is, the fewer actual
  customer contacts you will receive."
)

category.docs.create!(
 title: "How to get amazing article ideas that will cut your support costs by 50% or more",
 user_id: bot.id,
 body: "
  So by now you have hopefully set up your Google Analytics
  integration, because this is the first place you will go to get ideas.
  You see, Helpy is designed to help your customers help themselves.  Yeah,
  yeah, we have a pretty sweet ticket manager, but really the best
  customer service is when the customer never has to contact you.
  <br/><br/>
  So with your analytics integration you will start to see all the searches
  that users perform on your site.  This can be a real eye opener when it
  comes to understanding what problems customers have that your content is
  not addressing.  By connecting searches to tickets opened, you will
  immediately know which articles are missing.
  <br/><br/>
  It gets even better.  Helpy includes built in feedback on articles, so
  you will also be able to quickly learn which articles are well
  appreciated, and which need some improvement."
)

category.docs.create!(
  title: "How to get articles without even writing them",
  user_id: bot.id,
  body: "
  Did I get your attention with that headline or what?  Helpy
  includes an amazing feature that lets you turn ticket posts into
  articles.
  <br/><br/>
  Now I don’t suggest you go and convert private or sensitive customer
  information into public articles, but the reality is that the same
  questions seem to come up again and again, and capturing your answers
  and turning them into articles is just like getting a knowledgebase for
  free.
  <br/><br/>
  You can do this from the ticket manager, by clicking on the section
  that describes who wrote the post- ie “Scott replied…”.  Here you will
  see a dropdown menu that give you the option to “turn post into
  content.”

  You have two options here- either add it to your regular knowledgebase,
  or store it in the special category for “common replies.”  Common
  replies let you quickly reply to common questions with a pre-written
  response."
)

# Create sample group
tag = ActsAsTaggableOn::Tag.create(
  name: 'Example Group',
  description: 'This is an example group- typically used for a team or subset of agents',
  color: '#59de59',
  show_on_helpcenter: false,
  show_on_admin: false,
  show_on_dashboard: true,
)
ActsAsTaggableOn::Tagging.create(tag_id: tag.id, context: "teams")

# Create email header and footer tempalte

templates.docs.create!(title: 'Customer_header', body: '<!-- -->')
templates.docs.create!(title: 'Customer_footer', body:'<p style="color: #666;">
<small>
<strong>Powered by Helpy</strong><br>
Get a Free Helpy Support System for your Site at
<a href="https://helpy.io/">https://helpy.io/</a>
</small>
</p>
<p style="color: #666;"><small>%ticket_link%</small></p>')


# Create first example tickets

# Create first example tickets
topic = Forum.first.topics.create(
  name: 'How to upgrade to Helpy Cloud',
  private: true,
  assigned_user_id: admin.id,
  user_id: user_scott.id,
  current_status: 'new',
  channel: 'install'
)

topic.posts.create(
  body: '
  Upgrading to Helpy cloud is really easy, and involves paying for the license, then
  running the upgrade script supplied with your one click image.

  First, head over to https://helpy.io/on-premise and complete a purchase of the license.
  Once you have received the license code, SSH into your instance and execute the upgrade script
  with the following command:

  bash -c "$(wget -O - https://helpy.io/scripts/upgrade.sh)"

  After supplying your new license code, the script will shutdown your Helpy server,
  install the additional software, and then restart the server.

  <strong>What is included?</strong>

  <ul>
    <li>In App Notifications</li>
    <li>Realtime UI</li>
    <li>Advanced Reporting</li>
    <li>Advanced Search</li>
    <li>Triggers</li>
    <li>Custom Views</li>
    <li>LDAP</li>
    <li>Protected Helpcenter</li>
    <li>Carin the Customer Service Chatbot</li>
    <li>Helpy Chat (coming soon)</li>
  </ul>

  A full, current comparison on Helpy options is available here: <a href="https://helpy.io/open-source-helpdesk/">Comparison</a>
  ',
  user_id: user_scott.id,
  kind: 'first'
)

topic2 = Forum.first.topics.create(
  name: 'Welcome to Helpy',
  private: true,
  assigned_user_id: admin.id,
  user_id: user_scott.id,
  current_status: 'new',
  channel: 'install'
)

topic2.posts.create(
  body: '
  Thanks for installing Helpy and giving it a try  <img src="https://github.githubassets.com/images/icons/emoji/unicode/1f389.png?v8" style="width:20px;"><img src="https://github.githubassets.com/images/icons/emoji/unicode/1f31f.png?v8" style="width:20px;"><img src="https://github.githubassets.com/images/icons/emoji/unicode/1f4a5.png?v8" style="width:20px;"><img src="https://github.githubassets.com/images/icons/emoji/unicode/1f525.png?v8" style="width:20px;"><img src="https://github.githubassets.com/images/icons/emoji/unicode/1f4aa.png?v8" style="width:20px;">

  As the founding creator of Helpy, I am excited you decided to give it a look
  and I really hope you use it in your business. I have heard from a lot of you
  that Helpy is the best open source customer support solution out there, and is
  better than even most commercial choices, so thanks for that if you are included
  in this group.   <img src="https://github.githubassets.com/images/icons/emoji/unicode/1f4af.png?v8" style="width:20px;">

  <b>What is Helpy?</b>

  Helpy is a software platform that provides everything you need to run an awesome
  ticketing helpdesk and self service helpcenter website. You can even run a support
  forum where customers can help each other.&nbsp; The best part is Helpy core is 100%
  open source.

  <b>License, Open Core</b>

  Helpy is licensed under the MIT license, which means you can do, well, pretty
  much anything you want with it, other than removing the copyright/credits. Helpy
  is an open core application, which means the core functionality is open source,
  but there is additional functionality you can get if you purchase a license to 
  the enhanced version.


  <b>Support Open Source development by upgrading to Helpy Cloud</b>

  This installation of Helpy can easily be upgraded to the full Helpy Cloud 
  edition. Upgrading gets you access to our private gem server and a license to use 
  all of the cloud tier addons which are not open source and add amazing capabilities 
  like:

  <ul>
    <li>In App Notifications</li>
    <li>Realtime UI</li>
    <li>Advanced Reporting</li>
    <li>Advanced Search</li>
    <li>Triggers</li>
    <li>Custom Views</li>
    <li>LDAP</li>
    <li>Protected Helpcenter</li>
    <li>Carin the Customer Service Chatbot</li>
    <li>Agent Collision Detection</li>
    <li>Helpy Chat (coming soon)</li>
  </ul>

  <a href="https://helpy.io/on-premise" target="_blank" class="btn btn-default">Purchase Now</a><br/>
  A full, current comparison of Helpy options is available here: <a href="https://helpy.io/open-source-helpdesk/">Comparison</a>

  <b>Sponsorship Opportunities</b>

  Helpy is the leading open source helpdesk on GitHub, has over 100,000 Docker installs, 
  and has been featured on Product Hunt numerous times.  We have amassed a large audience of 
  developers, open source users, startups and CIO/CTO types.

  If your business sells to these types of people and you value aligning with the open
  source movement, sponsoring Helpy makes a lot of sense:

  The proceeds from supporters, sponsors and paying customers goes right back into
  further platform development. &nbsp;Supporting the project in some way makes good
  sense if you use Helpy in your business.

  <a href="https://www.patreon.com/helpyio" target="_blank" class="btn btn-default">Become a Supporter <img src="https://github.githubassets.com/images/icons/emoji/unicode/1f4aa.png?v8" style="width: 20px;"></a>
  ',
  user_id: user_scott.id,
  kind: 'first'
)

topic4 = Forum.first.topics.create(
  name: 'I am a ticket, here is what you can do with me',
  private: true,
  assigned_user_id: admin.id,
  user_id: bot.id,
  current_status: 'pending',
  tag_list: 'welcome messages'
)

topic4.posts.create(
  body: '
  Hey there!  I am a ticket.  In Helpy, a ticket is a communication between you (or your support staff) and a customer.  That ticket can be private (like a classic support ticket), or public for the world to see (and other customers to comment on.)

  You can choose whether or not to use the public forums feature- in fact you may have already shut it off in the onboarding when you first signed in.  If not, you can click the cog in the upper right and change it in the general settings.

  Next, click on the status dropdown- the one that currently says “Pending”.  Here you can mark the ticket as spam, new, resolved, or reopened if the ticket is already closed.

  Go ahead and choose resolved.  You will notice Helpy automatically logs your actions through internal notes- replies that are visible only to you and your team.  You will always be able to track the who, what, and when for a given ticket, which is really sweet!

  Your final task is to write a private note.  Click the radio button above the reply box, and type your note.  This is only visible to agents in your system.  Good job, you’ve finished this task and can click on the "Pending" box above to jump back to your other waiting tickets!

  PS- Got questions about this step?  Shoot me an email at scott@helpy.io
  ',
  user_id: bot.id,
  kind: 'first',
)

topic6 = Forum.first.topics.create(
  name: 'Make Helpy your Own: How to Customize',
  private: true,
  assigned_user_id: admin.id,
  user_id: bot.id,
  current_status: 'pending',
  tag_list: 'design',
)

topic6.posts.create(
  body: '
  By now you have seen the power of Helpy, and if you are like me, you are ready to make it your own :)  We’ve got you covered in the settings area, up there in the corner of the admin navigation bar (that gear shaped do-hickey).

  You’ve already done some configuration during the onboarding phase when you first logged in, but go ahead and click on the “General Settings” option.  This is where you can name your system, give it a custom URL, or provide a link back to your main site.

  Next, head to the design and theme settings.  You will use these to control the look and feel of your Helpy support center website.  You’ll probably want to start out by assigning your logo instead of using the Helpy logo (although we are fine with that if you want too.)  To do that just enter the URL to your logo file on your website.  You can do the same with your “favicon”, which is the tiny little logo that appears in your browser bar.

  Finally, you can change the theme your support center uses.  Clicking on “themes” brings up a selection of great themes for you to choose from.  To preview a theme, just click on the preview link in the description.

  For a full review of settings see: http://support.helpy.io/en/knowledgebase/18-configuring-your-helpy/docs/22-configuring-your-helpy-settings

  To learn how to use your own domain name, check out:
  http://support.helpy.io/en/knowledgebase/18-configuring-your-helpy/docs/48-using-a-cname-to-change-the-domain-of-your-helpy

  ',
  user_id: bot.id,
  kind: 'first',
)


topic7 = Forum.first.topics.create(
  name: 'Parlez-vous Francais? (Do you speak French)... or setting up to support multiple languages',
  private: true,
  assigned_user_id: admin.id,
  user_id: bot.id,
  current_status: 'pending',
  tag_list: 'international',
)

topic7.posts.create(
  body: '
  Does your business support customers in multiple languages?  If so, continue reading.  If not, you can go ahead and mark this ticket as “resolved.”

  Back on the settings panel, you no doubt saw a category for “International”.  This is how you turn on the multi-language features in Helpy.  The listing shows all of the languages currently supported in Helpy.  Check the box next to each language you want to support.  That’s it!

  Well, almost...  You should also identify a “default locale.”  Helpy will now localize itself to each user, selecting from the list of chosen languages.  If the user is from another area, the default will be used,

  A couple examples will make this clearer- Let’s imagine you provide support in French, Spanish and German, with French as the default.  Now someone visits from Italy.  Because you chose French as the default, that is what they will see (since Italian is not available.)

  Another example- You provide support in Russian, and only Russian.  You should only check “Russian er... Русский” and also set Русский as the default language.  Now your Helpy will only be available in Russian, ever, no matter where a user is from.

  Check out this article for more details: http://support.helpy.io/en/knowledgebase/17-self-service-knowledgebase/docs/9-how-to-set-up-a-multilingual-helpy-support-knowledgebase
  ',
  user_id: bot.id,
  kind: 'first'
)

public_topic = community.topics.create!(
  name: 'I am a public topic in the community',
  private: false,
  user_id: bot.id,
  current_status: 'open'
)

public_topic.posts.create!(
  body: '
  Did you enable community forums?  If so, this message is for you:

  One of your customers might have posted this message asking for help in the community forums.  The nice thing about this is that other customers can chip in to help answer questions, or your support team can post an answer.

  The question and responses are archived and fully searchable using Helpy’s search engine, so that customers with a similar question in the future can benefit from past questions.

  You can set up forums from the admin panel, and tickets are managed in the same way that private tickets are managed.  If a customer posts private information by accident, you can easily mark the ticket private, or vice versa if you think the conversation would benefit other users.
  ',
  user_id: bot.id,
  kind: 'first'
)

# Touching these will reorder them
topic7.touch
topic6.touch
topic4.touch
topic.touch
topic2.touch
