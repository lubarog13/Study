using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(CharacterController))]
public class PointClickMovement : MonoBehaviour
{
    [SerializeField] private Transform target;
    public float rotSpeed = 15.0f;
    public float moveSpeed = 6.0f;
    public float jumpSpeed = 15.0f;
    public float gravity = -9.8f;
    public float terminalVelocity = -10.0f;
    public float minFall = -1.02f;
    public float pushForce = 3.0f;

    private float _vertSpeed;
    private ControllerColliderHit _contact;
    private CharacterController _charController;

    public float deceleration = 25.0f;
    public float targetBuffer = 1.5f;
    private float _curSpeed = 0f;
    private Vector3 _targetPos = Vector3.one;
    
    private Animator _animator;
    // Start is called before the first frame update
    void Start()
    {
        _vertSpeed = minFall;
        _charController = GetComponent<CharacterController>();
        _animator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 movement = Vector3.zero;
        if (Input.GetMouseButton(0)) {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit mouseHit;
            if (Physics.Raycast(ray, out mouseHit)) {
                _targetPos = mouseHit.point;
                _curSpeed = moveSpeed;
            }
        }
        if (_targetPos != Vector3.one) {
            if (_curSpeed > moveSpeed * .5f) {
                Vector3 adjustedPos = new Vector3(_targetPos.x, transform.position.y, _targetPos.z);
                Quaternion targetRotation = Quaternion.LookRotation(adjustedPos - transform.position);
                transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, rotSpeed * Time.deltaTime);
            }
        }
        movement = _curSpeed * Vector3.forward;
        movement = transform.TransformDirection(movement);

        if (Vector3.Distance(_targetPos, transform.position) < targetBuffer) {
            _curSpeed -= deceleration * Time.deltaTime;
            if (_curSpeed <= 0) {
                _curSpeed = 0;
                _targetPos = Vector3.one;
            }
        }
        if (_vertSpeed < 0 && Physics.Raycast(transform.position, Vector3.down, out hit))
        {
                float check = (_charController.height + _charController.radius) / 1.9f;
                hitGround = hit.distance <= check;
        }
    }

    void OnControllerColliderHit(ControllerColliderHit hit)
    {
        _contact = hit;
        Rigidbody body = hit.collider.attachedRigidbody;
        if (body!=null && !body.isKinematic) {
            body.velocity = hit.moveDirection * pushForce;
        }
    }
}
