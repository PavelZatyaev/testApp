package ru.bezslovarya.test_task.controllers;

import java.security.Principal;
//import java.util.ArrayList;
//import java.util.Collection;
import java.util.Date;
//import java.util.HashMap;
import java.util.List;
//import java.util.Map;

import javax.validation.Valid;

import ru.bezslovarya.test_task.domain.GroupMember;
import ru.bezslovarya.test_task.domain.Message;
import ru.bezslovarya.test_task.domain.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.access.AccessDecisionManager;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCrypt;
//import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//import ru.bezslovarya.test_task.services.ProcessInterface;

import ru.bezslovarya.test_task.services.MessageService;
import ru.bezslovarya.test_task.services.UserService;
import ru.bezslovarya.test_task.services.AddressService;
import ru.bezslovarya.test_task.services.GroupMemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	// @Autowired
	// private AccessDecisionManager accessDecisionManager;

	// @Autowired
	// private ProcessInterface process;

	@Autowired
	private MessageService messageService;
	
	@Autowired
	private AddressService addressService;

	@Autowired
	private UserService userService;

	@Autowired
	private GroupMemberService groupMemberService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private Boolean editAddressBook=false;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/changePassword", method = RequestMethod.GET)
	public String changePassword(Model model) {
		model.addAttribute("user", new User());
		return "/content/changePassword";
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/__checkOldPassword", method = RequestMethod.GET, produces = { "text/html; charset=UTF-8" })
	public @ResponseBody String checkOldPassword(@RequestParam String password,  Integer check_password) {
		String flow_passwd = "";
		User user = new User();
		List<User> users = userService.listUser();
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		for (User u : users) {
			if (u.getUsername().equals(userDetails.getUsername())) {
				user = u;
				flow_passwd = user.getPassword();
				break;
			}
		}
		
		if (check_password.equals(1)) {
			return BCrypt.checkpw(password, flow_passwd) ? "1" : flow_passwd;
		}
		
		user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(11)));
		userService.addUser(user);
		return "1";
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
	public ModelAndView accesssDenied(Principal user) {

		ModelAndView model = new ModelAndView();

		if (user != null) {
			model.addObject("errorMsg", user.getName() + ": u don't have access to this page!");
		} else {
			model.addObject("errorMsg", "U don't have access to this page!");
		}

		model.setViewName("/content/accessDenied");
		return model;

	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String mainPage(Model model) {

		// !!! logger.info(process.getMessage());
		logger.info("log message");


		Integer userID = userService.getUserID();

		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		for (GrantedAuthority auth : userDetails.getAuthorities()) {
			if (auth.getAuthority().toString().equals("ROLE_ADMIN")) {
				model.addAttribute("IsAdmin", true);
				userID = -1;
				break;
			}
		}

		model.addAttribute("message", new Message());
		model.addAttribute("messageList", messageService.listMessage(userID));
		model.addAttribute("addressList", addressService.listAddress(userService.getUserID()));
		model.addAttribute("allAddressList", addressService.listAllAddress(userService.getUserID()));
		model.addAttribute("userMap", addressService.mapAddress(userService.getUserID()));
		
		if (editAddressBook) {		
			model.addAttribute("editAddressBook", 1);
			editAddressBook = false;
			}
		
		return "/content/user";
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminPage(Model model) {
		
		userService.adminOnly();
		
		model.addAttribute("userList", listUserEx());
		model.addAttribute("user", new User());

		return "/content/admin";
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/reg", method = RequestMethod.GET)
	public String regPage(Model model) {

		model.addAttribute("user", new User());

		return "/content/reg";
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/addUserReg", method = RequestMethod.POST)
	public String addUserReg(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
		
		if (result.hasErrors()) {
			return "/content/reg";
		}
	
		user.setIsAdmin(false);
		user.setEnabled(true);
		String user_plan_password = user.getPassword();
		user.setPassword(BCrypt.hashpw(user_plan_password, BCrypt.gensalt(11)));
	
		userService.addUser(user);

		model.addAttribute("user", user);
		model.addAttribute("user_plan_password", user_plan_password);
		
		return "/login";


//	
//		Authentication auth = 
//				  new UsernamePasswordAuthenticationToken(user.getUsername(), hashpw, getAuthorities());
//		SecurityContextHolder.getContext().setAuthentication(auth);	
//
//
//		model.addAttribute("message", new Message());
//		model.addAttribute("messageList", messageService.listMessage(user.getId()));
//		model.addAttribute("userMap", userService.mapUserName(user.getUsername()));
//		
//		return "/content/user";
	}
	
/*	private Collection<GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
        GrantedAuthority grantedAuthority = new GrantedAuthority() {
            public String getAuthority() {
                return "ROLE_USER";
            }
        }; 
        grantedAuthorities.add(grantedAuthority);
        return grantedAuthorities;
    }	
*/
	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = { "/", "/login" }, method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username or password!");
		}

		model.setViewName("login");
		return model;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/checkUserName_", method = RequestMethod.GET, produces = { "text/html; charset=UTF-8" })
	public @ResponseBody String checkUserName(@RequestParam String username) {
		List<User> users = userService.listUser();
		for (User u : users) {
			if (u.getUsername().equals(username))
				return "1";
		}
		return "0";
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public String addUser(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("userList", listUserEx());
			return "/content/admin";
		}

		user.setEnabled(true);
		user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(11)));

		userService.addUser(user);

		return "redirect:/admin";
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	private List<User> listUserEx() {
		List<User> ul = userService.listUser();
		List<GroupMember> gl = groupMemberService.listGroupMember();

		for (User u : ul) {
			for (GroupMember g : gl) {
				// 2 is magic number ))
				if (g.getUsername().equals(u.getUsername()) && g.getGroup_id() == 2) { 
					u.setAdminGroup("ADM");
					break;
				}
			}
		}
		return ul;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addMessage(@Valid @ModelAttribute("message") Message message, BindingResult result, Model model) {

		if (result.hasErrors()) {
			Integer userID = userService.getUserID();

			UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication()
					.getPrincipal();
			for (GrantedAuthority auth : userDetails.getAuthorities()) {
				if (auth.getAuthority().toString().equals("ROLE_ADMIN")) {
					model.addAttribute("IsAdmin", true);
					userID = -1;
					break;
				}
			}

			model.addAttribute("messageList", messageService.listMessage(userID));
			model.addAttribute("userMap", userService.mapUserName(userDetails.getUsername()));

			return "/content/user";
		}
		message.setUser_from_id(userService.getUserID());
		message.setUser_to_id(message.getUserID());
		message.setDt(new Date());
		messageService.addMessage(message);

		return "redirect:/user";
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/delete/{messageId}")
	public String deleteContact(@PathVariable("messageId") Integer messageId) {
		messageService.removeMessage(messageId);
		return "redirect:/user";
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/addUser2AB/{recipientID}")
	public String addUser2AB(@PathVariable("recipientID") Integer recipientID, Model model) {
		editAddressBook = true;
		addressService.addAddress(recipientID, userService.getUserID());
		return "redirect:/user";
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/delUserFromAB/{recipientID}")
	public String delUserFromAB(@PathVariable("recipientID") Integer recipientID, Model model) {
		editAddressBook = true;
		addressService.removeAddress(recipientID, userService.getUserID());
		return "redirect:/user";
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/deleteUser/{userId}")
	public String deleteUser(@PathVariable("userId") Integer userId) {
		userService.removeUser(userId);
		return "redirect:/admin";
	}

}
