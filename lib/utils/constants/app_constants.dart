import 'package:smart_ai/utils/constants/my_icons.dart';

class AppConstants {
  static const appName = 'SmartAI';

  // Shared Preferences Key
  static const rememberMeKey = 'remember_me';
  static const phoneNumberKey = 'phone_number';
  static const passwordKey = 'password';
  static const userModelKey = 'user_model';
  static const accessTokenKey = 'access_token';

  static const welcomeDescription = [
    {
      'icon': MyIcons.search,
      'title': 'Accuracy Disclaimer',
      'description': 'SmartAI is may not always provide 100% accurate response.'
    },
    {
      'icon': MyIcons.lock,
      'title': 'Privacy Reminder',
      'description':
          'Avoid sharing sensitive or personal information in your conversations.'
    },
    {
      'icon': MyIcons.filter,
      'title': 'Chat History Control',
      'description':
          'You have the power to manage and delete your chat history within the app.'
    },
    {
      'icon': MyIcons.star,
      'title': 'Unlock More',
      'description':
          'Explore SmartAI Pro for enhanced features and limitless possibilities.'
    },
  ];

  static const capabilities = [
    'Answer all your questions.\n(Just ask me anything you like!)',
    'Generate all the text you want.\n(essays, articles, reports, stories, & more)',
    'Conversational AI.\n(I can talk to you like a natural human)',
  ];

  static const menuAssistants = [
    'All',
    'Writing',
    'Creative',
    'Business',
    'Social Media',
    'Developer',
    'Personal',
    'Others',
  ];

  static const freeDescription = [
    'Ad-supported experience',
    'Access to limited chatbot features',
    'Limit image generation',
    'Limit image history storage',
    'Limited chat history storage'
  ];
  static const planDescription = [
    'Ad-free experience',
    'Full access to all chatbot features',
    'Priority customer support',
    'AI-powered conversation insights',
    'Unlimited chat history storage',
    'Unlimited image history storage',
  ];

  static const productIds = [
    'smartai_month',
    'smartai_three_months',
    'smartai_six_monthss',
    'smartai_year',
  ];

  static var assistants = [
    {
      'id': 1,
      'icon': MyIcons.voice,
      'type': menuAssistants[1],
      'color': '#4AAF57',
      'title': 'Write an Articles',
      'description': 'Generate well-written articles on any topic you want.',
    },
    {
      'id': 2,
      'icon': MyIcons.voice,
      'type': menuAssistants[1],
      'color': '#1A96F0',
      'title': 'Academic Writer',
      'description':
          'Generate educational writing such as essays, reports, etc.',
    },
    {
      'id': 3,
      'icon': MyIcons.voice,
      'type': menuAssistants[1],
      'color': '#F54336',
      'title': 'Summarize (TL;DR)',
      'description': 'Extract key points from long texts.',
    },
    {
      'id': 4,
      'icon': MyIcons.voice,
      'type': menuAssistants[1],
      'color': '#FF981F',
      'title': 'Translate Language',
      'description': 'Translate from one language to another.',
    },
    {
      'id': 5,
      'icon': MyIcons.voice,
      'type': menuAssistants[1],
      'color': '#9D28AC',
      'title': 'Plagiarism Checker',
      'description': 'Check the level of text plagiarism with AI.',
    },
    {
      'id': 6,
      'icon': MyIcons.voice,
      'type': menuAssistants[2],
      'color': '#FFC02D',
      'title': 'Songs/Lyrics',
      'description': 'Generate lyrics from any music genre you want.',
    },
    {
      'id': 7,
      'icon': MyIcons.voice,
      'type': menuAssistants[2],
      'color': '#00BCD3',
      'title': 'Storyteller',
      'description': 'Generate stories from any given topic.',
    },
    {
      'id': 8,
      'icon': MyIcons.voice,
      'type': menuAssistants[2],
      'color': '#8BC255',
      'title': 'Poems',
      'description': 'Generate poems in different styles.',
    },
    {
      'id': 9,
      'icon': MyIcons.voice,
      'type': menuAssistants[2],
      'color': '#673AB3',
      'title': 'Movie Script',
      'description': 'Generate the script for the movie.',
    },
    {
      'id': 10,
      'icon': MyIcons.voice,
      'type': menuAssistants[3],
      'color': '#7A5548',
      'title': 'Email Writer',
      'description': 'Generate templates for emails, letters, etc.',
    },
    {
      'id': 11,
      'icon': MyIcons.voice,
      'type': menuAssistants[3],
      'color': '#607D8A',
      'title': 'Answer Interviewer',
      'description': 'Generate answers to interview questions.',
    },
    {
      'id': 12,
      'icon': MyIcons.voice,
      'type': menuAssistants[3],
      'color': '#EA1E61',
      'title': 'Job Post',
      'description': 'Write ideal job descriptions for posting.',
    },
    {
      'id': 13,
      'icon': MyIcons.voice,
      'type': menuAssistants[3],
      'color': '#FF5726',
      'title': 'Advertisements',
      'description':
          'Generate promotional text for products, services, brands, etc.',
    },
    {
      'id': 14,
      'icon': MyIcons.voice,
      'type': menuAssistants[4],
      'color': '#FFC02D',
      'title': 'LinkedIn',
      'description': 'Create attention-grabbing posts on LinkedIn.',
    },
    {
      'id': 15,
      'icon': MyIcons.voice,
      'type': menuAssistants[4],
      'color': '#8BC255',
      'title': 'Instagram',
      'description': 'Write captions that attract audience on Instagram.',
    },
    {
      'id': 16,
      'icon': MyIcons.voice,
      'type': menuAssistants[4],
      'color': '#3F51B2',
      'title': 'Twitter',
      'description':
          'Make tweets that catch the attention of readers on Twitter.',
    },
    {
      'id': 17,
      'icon': MyIcons.voice,
      'type': menuAssistants[4],
      'color': '#009689',
      'title': 'TikTok',
      'description': 'Create attention-grabbing and viral captions on TikTok.',
    },
    {
      'id': 18,
      'icon': MyIcons.voice,
      'type': menuAssistants[4],
      'color': '#00BCD3',
      'title': 'Facebook',
      'description': 'Create attention-grabbing posts on Facebook.',
    },
    {
      'id': 19,
      'icon': MyIcons.voice,
      'type': menuAssistants[5],
      'color': '#4AAF57',
      'title': 'Write Code',
      'description': 'Write app & websites in any programming language.',
    },
    {
      'id': 20,
      'icon': MyIcons.voice,
      'type': menuAssistants[5],
      'color': '#F54336',
      'title': 'Explain Code',
      'description': 'Explain complicated programming code snippets.',
    },
    {
      'id': 21,
      'icon': MyIcons.voice,
      'type': menuAssistants[6],
      'color': '#FFC02D',
      'title': 'Birthday',
      'description': 'Create sincere birthday wishes for loved ones.',
    },
    {
      'id': 22,
      'icon': MyIcons.voice,
      'type': menuAssistants[6],
      'color': '#CDDC4C',
      'title': 'Apology',
      'description': 'Make an apology for the mistakes that have been made.',
    },
    {
      'id': 23,
      'icon': MyIcons.voice,
      'type': menuAssistants[6],
      'color': '#00A9F1',
      'title': 'Invitation',
      'description': 'Write the perfect invitation for any event.',
    },
    {
      'id': 24,
      'icon': MyIcons.voice,
      'type': menuAssistants[7],
      'color': '#9D28AC',
      'title': 'Create Conversation',
      'description': 'Create conversation templates for two or more people.',
    },
    {
      'id': 25,
      'icon': MyIcons.voice,
      'type': menuAssistants[7],
      'color': '#607D8A',
      'title': 'Tell a Joke',
      'description':
          'Write funny jokes to tell your friends and make them laugh.',
    },
    {
      'id': 26,
      'icon': MyIcons.voice,
      'type': menuAssistants[7],
      'color': '#F54336',
      'title': 'Food Recipes',
      'description': 'Get any cooking recipes for food dishes.',
    },
    {
      'id': 27,
      'icon': MyIcons.voice,
      'type': menuAssistants[7],
      'color': '#8BC255',
      'title': 'Diet Plan',
      'description': 'Create meal plans and diets based on your preferences.',
    },
  ];

  static const somethingLikes = {
    '1': [
      'Write an article discussing the benefits of practicing mindfulness in daily life.',
      'Write an article discussing the impact of climate change on the planet.',
      'Write an article discussing the importance of maintaining a healthy work-life balance.',
    ],
    '2': [
      'Write an academic essay about the impact of climate change on global food security.',
      'Write an academic essay about the role of technology in shaping modern education.',
      'Write an academic essay about the ethics of artificial intelligence and its impact on society.',
    ],
    '3': [
      'Summarize this article "The effectiveness of cognitive-behavioral therapy in treating depression....."',
      'Summarize this essay "An analysis of the impact of social media on mental health....."',
      'Summarize this story "An Old Man in the Village....."',
    ],
    '4': [
      'Translate the following sentences into English "Consejos para mantenerse motivado y productivo mientras trabaja desde casa."',
      'Translate the following sentences into Vietnamese "What is your name?"',
      'Translate the following sentences into Korean "Impactul schimbărilor climatice asupra securității alimentare globale."',
    ],
    '5': [
      'I want to check the plagiarism of this article "Social media has completely transformed the way we communicate and interact ..."',
      'What is the level of originality of this essay "One of the ways globalization has contributed to income inequality is ..."',
      'What percentage level of plagiarism emerges from this thesis "Globalization has been a driving ..."',
    ],
    '6': [
      'Make me lyrics of a broken heart because of love',
      'I want to make a song with the theme of true friends',
      'Make me a rock song with an anti-war subject',
    ],
    '7': [
      'Make me a bedtime story about a girl with a magic stone',
      'I want to make a short novel story about a friendship in high school',
      'I want to write a short story about the meaning of love and friends',
    ],
    '8': [
      'Make me a poems with the theme of justice and social criticism',
      'I want to write a poems about divinity',
      'I want to write a poem on the subject of failure in life and rising to success',
    ],
    '9': [
      'Give me a script for a comedy set in an amusement park',
      'I want to write a short film script about life and friends in high school',
      'Make me a romance-themed film script with a background in the 80s in Europe',
    ],
    '10': [
      'Write me a cover letter for the Product Designer position at Google company.',
      'I want to write an email to the boss that I can not enter the office due to illness.',
      'Write me a template email message to my customers that I have an exciting new product.',
    ],
    '11': [
      'Give me the answer to the interview question "What salary do you want?"',
      'What is the best answer to the interview question "What motivates you to work for this company?"',
      'Give me a way to answer the interview question "What contribution can you make to the company?"',
    ],
    '12': [
      'Make me a job post with the position of Product Designer for my company.',
      'I want to write a job post for a new employee in my office',
      'Give me a short but interesting job post for a researcher position for a research project',
    ],
    '13': [
      'I have a salon service, give me advertising words for marketing purposes on social media',
      'Give me advertisements for perfume products that I just released to attract buyers',
      'Write me an advertisement for food bazaar event and big discount on sunday',
    ],
    '14': [
      'I need a LinkedIn post idea that showcases my programs and its unique value proposition to my audience clearly and concisely.',
      "I'm looking for a LinkedIn post idea that shares a recent success story with my service and highlights its positive impact on my customer",
      'Can you help me develop a LinkedIn post idea that features a testimonial from one of my client and how my product helped solve their specific problem?',
    ],
    '15': [
      "I'm looking for an Instagram post idea that will showcase the unique features and benefits of my product and convince my customer to make a purchase.",
      'I need an Instagram post idea that will highlight the social proof and positive reviews of my service to build trust and credibility with my target audience.',
      "I'm looking for an Instagram post idea that will educate my audience on the benefits and uses of my service in a creative and engaging way.",
    ],
    '16': [
      'I need a tweet idea to promote my online course product for the ideal customer on twitter to buy it',
      'I need an tweet idea that will tell the story behind my company and its mission to connect with my target audience on a personal level.',
      "I'm looking for an tweet post idea that will feature user-generated content and showcase how my product is making a difference in the lives of real people.",
    ],
    '17': [
      'I need a TikTok caption post idea that will showcase my novel ebook in action through a demo video or product tutorial.',
      "I'm looking for a caption tiktok post idea that will tap into the current trending topics and relate it to my cosmetic product in a fun and entertaining way.",
      "I'm looking for a TikTok caption post idea that will ask a question to my audience and encourage them to engage in the comments section.",
    ],
    '18': [
      'I need a Facebook post idea that will showcase my digital product in action with real-life examples of how it has benefited my customers.',
      'I need a Facebook post idea that will share a personal experience or success story related to my design course and inspire my audience.',
      'I need a Facebook post idea that will introduce my ebook in an attention-grabbing way and highlight its unique features that differentiate it from competitors.',
    ],
    '19': [
      'Give me a CRUD function in Python programming language',
      'How do I make an HTTP request in Javascript, PHP, and Python?',
      'Locate any logic errors in the following [language] code snippet: [code snippet].',
    ],
    '20': [
      'I have the PHP code, but I don\'t know what it means. Can you explain this code "Paste your code here"',
      'Can you explain this code, find logic errors, and potential performance issues if an "Paste your code here"',
      'Describe the function of this code, find deadlock issues, and potential SQL injection vulnerabilities if any "Paste your code here"'
    ],
    '21': [
      "Write me a heartfelt wish for my daughter's 12th birthday",
      "I want to wish my mother a sincere happy birthday who will be 60 years old",
      "Write me a sincere wish for my boyfriend who has a birthday tomorrow",
    ],
    '22': [
      'I disappointed friends by forgetting an important appointment, can I make a sincere apology?',
      'I made my mother angry, write me a sincere apology',
      "I dropped my girlfriend Sarah's favorite cosmetics, what should I say to apologize?",
    ],
    '23': [
      'I have a talk show event on Saturday night, can I make an invitation for me to share with my audience?',
      "I'm having my 16th birthday, I want to make an invitation for my childhood friend Magie.",
      'I want to make a dinner party with my high school friends, please make me an invitation to give them.',
    ],
    '24': [
      'Write me a conversation between 4 people discussing tourist destinations in America.',
      'Do me a two person conversation between John & Lily about attending a school reunion.',
      'Give me a short conversation between three people discussing quantum physics.',
    ],
    '25': [
      'Tell me a joke about lion',
      'Throw me some high school jokes',
      'Write me 5 jokes about giraffes for me to tell my friends.',
    ],
    '26': [
      'I want to eat a salad, give me a simple salad recipe with the main ingredients avocado, cabbage, tomatoes and carrots.',
      'Give me a recipe for making Korean oriental Pajeon that’s not so spicy.',
      'Give me an Italian food recipe that is low in fat and cholesterol.',
    ],
    '27': [
      'I weigh 80 kg, I want a diet plan to eat vegetables without avocado and cabbage because I hate it.',
      'I want a fruit diet plan without pineapple and papaya for 1 full month.',
      "Put me on a nut, tomato and fish free diet plan because I'm allergic to them.",
    ],
  };
}
