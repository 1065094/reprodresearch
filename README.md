# reprodresearch
PLEASE CLICK THIS LINK TO SEE ALL CODE AND FIGURES!
https://rpubs.com/a1065094/1125146
Attached is the link to access my HTML document as a whole as it is too large for GitHub to process.


## Question 3
C) Reflect on your experience running their code. (300-500 words)
- <div>What elements of your partner's code helped you to understand their data pipeline?</div> 
I was particularly impressed with the cleaning section of the code since the student made use of new inclusions within the code learnt from the session to help improve the cleaning process. I also enjoyed the presence of interactive plots which made me feel like I was getting the necessary information from the graph as a whole since it was easy to see the overall distribution, but also specific detail was available if needed. This helped me then see how they were answering their biological question from the code which is great! I also think an appropriate test was chosen for the type of variables that they were using (ANOVA). I was pleasantly surprised to see a post-hoc test being conducted too! (Tukey HSD).

- <div>Did it run?</div> 
Yes, I downloaded the markdown from the GitHub and ran it in my RStudio. I then found that there was a slight issue with regards to the naming of the chunks within the curly brackets. This would result in an error, where it referred to a zero-length variable name, however the code would work when just the code was ran! Therefore, I ran it in chunks and made sure the notes about the discussion and such would not interfere with the process.

-	<div>Any suggestions?</div>
One suggestion would be to either justify or remove the density function on the interactive violin plot. Although the interaction of the points are very useful to understand the data, it is hard to see how the density provides sufficient information and this has not been mentioned within the comments. Another suggestion would just be to remove the names of chunks within the {r} so the markdown can run all at once. Perhaps it would be useful to have a few more comments on the interpretation of the ANOVA or steps taken in general, because although there were some comments, it would make it more understandable for someone who may not be from a biological background. An AIC could have also been conducted to justify the use of the ANOVA.

- <div>If I needed to alter their figures, would be easy or not?</div>
I think it would be easy to alter the figures of my partner since there are comments on almost each line or before the code is conducted to give sufficient context. The code is also quite clear and not complex, so it would be straightforward for me! I particularly liked the way a comment clarified how alpha must be altered to have differing transparency so that we can avoid over plotting. 

D)
- <div>What did I learn about writing code for others?</div>
Based on my partner's code, I believe my code would benefit from restructuring to make sure it is clear where each section starts and ends with reference to the introduction, statistical methods etc. and placing comments in the relevant sections of code to help provide informative and summarised headings. However, although this seems contradictory, I would shorten some sections where there are many comments. This is because I really appreciated how succinct my partner’s comments were. Additionally, based on the feedback I was given and what I had observed within their code, I believe I would have benefited from explicit justifications at times like, clearly stating the type of variables used and how this informed my choice of statistical test. 

Additionally, based on the feedback I was provided with, I am very much willing to adapt my code where I explain the presence of graphs that tested for assumptions and specifying the version of packages used.

Finally, I would also work on my slider as mentioned to make sure that it can reset and show all three species at once again. This is because as noticed by my partner and I, once you use the slider to view one species, you cannot go back to the initial view of the graph. Although you can see all three species at once in the next figure (1B), I believe it would be beneficial for the interactivity in my graph to work well regardless so that even if a person chooses to isolate and reproduce this they can. I therefore agree with the review that my partner has given me!

-	<div>What did I learn about writing code for other people?</div>
I learnt then when writing code for others, it is not only about the clarity of the code with regards to the structure and the comments supporting it; it is s also about simplifying complex code. For example, through the use of functions as demonstrated by this exercise. I think being able to do this assignment was valuable as it taught me the importance of my code functioning on other computers or my own but through virtual versions of R (for example: on Post it Cloud).

This is because often times I found that my code would not work if I suddenly opened a new R project or script since certain variables and such were formed that were particular to that project/script only. This did highlight an issue for me, but because it tended to work on my device alone it did not seem alarming until I learnt about the concept of reproducibility. This helped me appreciate GitHub since you can collaborate with others on code to get feedback and allow open access.

A similar issue has arisen before when trying to work on coding projects with others, where due to data being saved to a local device others cannot access. Therefore, I learnt the importance of creating projects where the initial dataset and the cleaned version can be viewed and also making it easy to understand how we went through this process!



