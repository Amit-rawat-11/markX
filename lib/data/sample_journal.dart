import 'package:mark_x/models/journal.dart';

List<JournalEntry> demoJournalEntries = [
  JournalEntry(
    title: "Morning Vibes",
    content:
        "Woke up with a fresh mindset today. The morning was calm, and I spent some time reflecting on my goals for the day. I didn’t rush into anything; instead, I took a moment to sit by the window and watch the sunrise. There was something peaceful about the quiet morning. I started my day with a simple cup of coffee, letting its warmth settle in before jumping into my usual routine. I decided to take some time for light stretching as well, just to wake up my body. It felt good to just be present and not rush into the day. The peace and tranquility of the morning helped set the tone for the rest of the day, and I promised myself to take more mornings like this one. It’s a reminder that sometimes, a slow start is the best way to build momentum. Grateful for moments like these.",
    timestamp: DateTime.now().subtract(Duration(days: 1, hours: 2)),
  ),
  JournalEntry(
    title: "Creative Flow",
    content:
        "Today was one of those magical days where ideas just kept flowing. I had this sudden surge of creativity, and before I knew it, I was jotting down notes, sketching out concepts, and finalizing some projects I’ve been working on. It felt like everything was falling into place. I even found time to brainstorm new ideas for some of my future projects. The best part? It wasn’t forced. I wasn’t trying to be creative; it just came naturally. It felt like the universe was in sync with my thoughts today. Every step I took led me to something new and exciting. I really enjoy these bursts of inspiration, and I’m trying to learn how to embrace them even more. When creativity hits, it’s like a flow state — everything just aligns, and time seems to stop. Looking forward to seeing where these ideas take me!",
    timestamp: DateTime.now().subtract(Duration(days: 1)),
  ),
  JournalEntry(
    title: "Productivity Boost",
    content:
        "I’m feeling super accomplished today. It was one of those days where I managed to get a lot done. I woke up with a burst of energy and decided to take full advantage of it. From the moment I sat down at my desk, I didn’t waste any time. I went through my to-do list, knocking out tasks one after the other, and before I knew it, I had finished everything I had planned for the day. I even got a head start on some work for tomorrow. What made today even better was that I didn’t feel rushed or stressed. I was in a good rhythm, and the work didn’t feel overwhelming. This is the kind of productivity I want to aim for every day. I’ve realized that the key to staying productive is not just about working harder but also working smarter. I’m learning to listen to my energy levels and take breaks when needed. Feeling proud of what I’ve accomplished today, and I’m hoping to keep this momentum going.",
    timestamp: DateTime.now().subtract(Duration(days: 2)),
  ),
  JournalEntry(
    title: "Unplugged Moment",
    content:
        "I decided to take a break from screens today, and honestly, it was exactly what I needed. Sometimes it feels like everything is happening online, and you can get lost in the endless notifications and updates. So I left my phone at home and went for a walk outside, no distractions, no pressure. The weather was perfect, and I could hear the sounds of the world around me — birds chirping, wind rustling through the leaves, and the distant laughter of children playing. It was so grounding to just be present in nature. I walked aimlessly, letting my thoughts wander freely. It’s funny how much you miss when you're always on your phone. I came back feeling refreshed, clear-headed, and more connected to the world around me. It made me realize how important it is to take these moments to unplug and recharge.",
    timestamp: DateTime.now().subtract(Duration(days: 3, hours: 5)),
  ),
  JournalEntry(
    title: "Mindful Rest",
    content:
        "Today, I focused on giving myself the rest I needed. The past few weeks have been a whirlwind of work, meetings, and endless to-do lists. So, I decided to slow down today. I took a few hours to relax and do things that calm my mind. I did a bit of journaling, letting my thoughts flow without worrying about what I had to do next. I also spent some time reading a book I’ve been meaning to get back to. Sometimes, we push ourselves too hard, thinking that productivity means being busy all the time, but I’ve learned that rest is just as important as work. After some quiet time and self-care, I felt more recharged and ready to tackle what’s next. Sometimes, we just need to step back and allow ourselves to reset. It was a good reminder that balance is key.",
    timestamp: DateTime.now().subtract(Duration(days: 4)),
  ),
  JournalEntry(
    title: "Small Victory",
    content:
        "Celebrating small victories today! I’ve been working on a project for a while, and today I shared my new UI design draft with my mentor. To my surprise, he absolutely loved it! Getting positive feedback felt amazing. It reminded me that even small wins deserve to be celebrated because they’re a sign that I’m on the right track. Designing is often a solitary process, and it’s easy to question if you’re making the right decisions. But hearing someone acknowledge the effort you’ve put in gives you a huge confidence boost. It’s not about ego; it’s about validation. It’s also about pushing yourself to improve, even when you’re uncertain. I’m excited to keep working on this design and see how it evolves. Small victories, big confidence!",
    timestamp: DateTime.now().subtract(Duration(days: 5)),
  ),
  JournalEntry(
    title: "Random Thoughts",
    content:
        "Today, I found myself lost in thought about how life moves so fast. Sometimes, we don’t take a moment to appreciate what’s happening in the present. I was thinking about my growth over the past year, all the changes I’ve gone through, and the challenges I’ve faced. It’s easy to get caught up in what’s next, always striving for more, but it’s important to look back and acknowledge how far we’ve come. I spent some time reflecting on my journey today and reminded myself that it’s okay to slow down and take things one step at a time. I don’t need to have everything figured out right now. Life is a constant evolution, and I’m learning to embrace it, even the messy parts. It’s a comforting thought to know that change is constant, and I can adapt to whatever comes my way.",
    timestamp: DateTime.now().subtract(Duration(days: 6)),
  ),
  JournalEntry(
    title: "Focused Session",
    content:
        "Today, I decided to have a focused deep-work session. I set aside two hours to work on a feature for my app, making sure to avoid distractions. I turned off all notifications, put my phone on silent, and focused solely on the task at hand. It was incredible how much I accomplished in that time. I wasn’t jumping from task to task, but instead, I gave my full attention to one thing. That’s when I realized how powerful focus is. The flow state is real. I was so absorbed in my work that I lost track of time. It’s amazing what we can achieve when we really commit to being present. I’m going to make focused deep work a habit from now on. It’s definitely a game changer.",
    timestamp: DateTime.now().subtract(Duration(days: 7)),
  ),
  JournalEntry(
    title: "Thoughts on Change",
    content:
        "Change is always a challenge, but it’s something I’m learning to embrace more. Today, I reflected on some recent changes in my life and the lessons I’ve learned from them. It’s not always easy to accept change, especially when it feels uncertain or uncomfortable. But I’ve realized that change is necessary for growth. Without change, we stay stagnant. Even though it can be difficult, change pushes us to become better versions of ourselves. I’ve faced a lot of uncertainty lately, but I’ve been trying to approach it with an open mind and heart. It’s okay not to have everything figured out. Change will always come, and I’ll continue to navigate it the best way I can.",
    timestamp: DateTime.now().subtract(Duration(days: 8)),
  ),
  JournalEntry(
    title: "Gratitude Moment",
    content:
        "Today, I took a moment to reflect on what I’m grateful for. Even though life can be tough at times, there’s always something to be thankful for. I’m grateful for the people in my life, the opportunities I have, and the little moments that make life special. I’m also grateful for the challenges, because they’ve taught me so much. They’ve made me stronger and more resilient. Grateful for the ability to grow and evolve, for the lessons learned from both my successes and failures. I’m grateful for the simple things — a warm meal, a good conversation, the beauty of nature, the feeling of peace after a long day. Gratitude really does change your perspective. It makes everything feel softer, more manageable. And today, I’m ending with a full heart.",
    timestamp: DateTime.now().subtract(Duration(days: 9)),
  ),
];
